Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbWHXK1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbWHXK1p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 06:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbWHXK1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 06:27:45 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:1703 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1751040AbWHXK1o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 06:27:44 -0400
Date: Thu, 24 Aug 2006 11:28:01 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [HELP] Power management for embedded system
Message-ID: <20060824102801.GA19881@linux-mips.org>
References: <20060824084425.83538.qmail@web25802.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824084425.83538.qmail@web25802.mail.ukl.yahoo.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 08:44:25AM +0000, moreau francis wrote:

> I'm currently working on a small embedded system based on a MIPS
> processor. So far Linux works fine on it and I'd like to implement
> power management on this system. For now I realize that APM and ACPI
> are implemented by the kernel.
> 
> I don't think that ACPI is really suited for what I need. So I took a
> look to APM implemetation which seems to be only implemented on i386,
> arm and mips architectures. All of these implementations seem to be
> based on i386 one. Mips one seems to be a copy and paste of arm one
> and both of them have removed all APM bios stuff orginally part of
> i386 implementation. It doesn't seem that APM is something really
> stable and finished. So now I do not know from where to start...

All the APM emulation on ARM and MIPS is really meant to is providing the
same interface to applications.  It doesn't interface to an APM BIOS
because there is none and that's really excellent news.

> Is there some other effort in the power management for _embedded_
> systems ? I'd like to help in this area and it would be helpful to
> know of certain projects that are working in this direction.

  Ralf
