Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263938AbTEFRPK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 13:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263992AbTEFRPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 13:15:09 -0400
Received: from air-2.osdl.org ([65.172.181.6]:39058 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263938AbTEFRPI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 13:15:08 -0400
Subject: Re: 2.5.69: Missing logo?
From: Andy Pfiffer <andyp@osdl.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       James Simmons <jsimmons@transvirtual.com>
In-Reply-To: <20030506180707.B15174@flint.arm.linux.org.uk>
References: <20030506180707.B15174@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1052241905.1238.3.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 06 May 2003 10:25:05 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-06 at 10:07, Russell King wrote:
> Hi,
> 
> I seem to have a penguin missing in action, somewhere between 2.5.68 and
> 2.5.69.  Has anyone else lost a penguin under similar circumstances?

Tux is AWOL for me, too.

bk/linux-2.5.69+kexec2> grep LOGO .config
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
bk/linux-2.5.69+kexec2> grep CONFIG_FB .config | grep =y
CONFIG_FB=y
CONFIG_FB_VESA=y
CONFIG_FB_I810=y
CONFIG_FB_I810_GTF=y
bk/linux-2.5.69+kexec2> lspci | grep -i VGA
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP
(rev 85)
bk/linux-2.5.69+kexec2>


> $ grep LOGO linux-sa1100/.config
> CONFIG_LOGO=y
> # CONFIG_LOGO_LINUX_MONO is not set
> CONFIG_LOGO_LINUX_VGA16=y
> CONFIG_LOGO_LINUX_CLUT224=y
> 
> Other than the missing logo, the fb display looks as it did under 2.5.68.


