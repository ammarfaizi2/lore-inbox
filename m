Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbTD2X4M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 19:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbTD2X4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 19:56:11 -0400
Received: from dp.samba.org ([66.70.73.150]:4304 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261923AbTD2X4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 19:56:11 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16047.5071.134659.883564@nanango.paulus.ozlabs.org>
Date: Wed, 30 Apr 2003 10:07:43 +1000 (EST)
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Late -rc2 
In-Reply-To: <Pine.LNX.4.53L.0304291816450.15908@freak.distro.conectiva>
References: <Pine.LNX.4.53L.0304291816450.15908@freak.distro.conectiva>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti writes:

> I thought I would be able to release -rc2 sooner, but due to the
> some issues (mostly the ptrace issue discussed here) it got a bit late.
> 
> I hope to have it out tomorrow.

Have you fixed drivers/video/Config.in?  I just did a pull from
bk://linux.bkbits.net/linux-2.4 and it still had the typo in the
statement for setting CONFIG_FBCON_CFB8.

On the PPC side, there is a 1-line compile fix for
arch/ppc/kernel/ppc_ksyms.c that we need (including <asm/div64.h>),
plus I have an update for the defconfigs.

Paul.
