Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVBRM0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVBRM0g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 07:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVBRM0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 07:26:36 -0500
Received: from oracle.bridgewayconsulting.com.au ([203.56.14.38]:14256 "EHLO
	oracle.bridgewayconsulting.com.au") by vger.kernel.org with ESMTP
	id S261336AbVBRM0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 07:26:33 -0500
Date: Fri, 18 Feb 2005 20:26:52 +0800
From: Bernard Blackham <bernard@blackham.com.au>
To: Pavel Machek <pavel@ucw.cz>
Cc: dtor_core@ameritech.net, John M Flinchbaugh <john@hjsoft.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Swsusp, resume and kernel versions
Message-ID: <20050218122652.GF30342@blackham.com.au>
References: <200502162346.26143.dtor_core@ameritech.net> <20050217110731.GE1353@elf.ucw.cz> <20050217162847.GA32488@butterfly.hjsoft.com> <d120d5000502170930ccc3e9e@mail.gmail.com> <20050217195651.GB5963@openzaurus.ucw.cz> <20050218020220.GD30342@blackham.com.au> <20050218112409.GB1341@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050218112409.GB1341@elf.ucw.cz>
Organization: Dagobah Systems
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2005 at 12:24:09PM +0100, Pavel Machek wrote:
> If you want to be 100% safe, add support to LILO/GRUB: just do not
> allow selecting wrong kernel if last action was suspend. Bootloader
> knows, it seen the command lines.

That's a very good point/solution indeed. The hibernate script
available from the Software Suspend 2 homepage already has options
to reconfigure LILO/GRUB upon suspending. I'd forgotten about them!

Bernard.

-- 
 Bernard Blackham <bernard at blackham dot com dot au>
