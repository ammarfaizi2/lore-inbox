Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVBTV01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVBTV01 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 16:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVBTV01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 16:26:27 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:42897 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S261156AbVBTV0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 16:26:24 -0500
Date: Sun, 20 Feb 2005 22:26:23 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: linux-kernel@vger.kernel.org
Subject: Re: IBM Thinkpad G41 PCMCIA problems [Was: Yenta TI: ... no PCI
Message-ID: <20050220212622.GA18447@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502200954350.2378@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Feb 2005, Linus Torvalds wrote:
>Russell, what do your eagle-eyes think of a patch like this?
>
>Steven, does this fix it without the need for any kernel command line (or
>any other patches, for that matter - ie revert all the transparency-
>changing ones)?
>
>		Linus

I tried the patch on my G40 with 1Gb RAM (previous thread about it is at 
http://marc.theaimsgroup.com/?t=110889153400001&r=1&w=2), and it works 
great, PCI resources are now located at 0x40000000 and no further 
tricks/patches are necessary.

Re,
David

