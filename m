Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271055AbTHGXM7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 19:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271103AbTHGXM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 19:12:59 -0400
Received: from [203.51.27.20] ([203.51.27.20]:18418 "EHLO e4.eyal.emu.id.au")
	by vger.kernel.org with ESMTP id S271055AbTHGXM5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 19:12:57 -0400
Message-ID: <3F32DCE9.74E61CF9@eyal.emu.id.au>
Date: Fri, 08 Aug 2003 09:12:41 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.22-rc1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Rankin <rankincj@yahoo.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Loading Pentium III microcode under Linux - catch 22!
References: <20030807143831.73389.qmail@web40603.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Rankin wrote:
> 
>  --- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > As far as I am aware none of the microcode updates
> > even apply to 933Mhz era PIII, just the ones the
> > BIOS ships with by default nowdays. Also the kind of
> > stuff the errata fix are obscure ultra-weird corner
> > cases people just don't hit.
> 
> Lucky me, eh?
> 
> My CPUs *do* take microcode, and they are 933 MHz...
> ;-). I upgraded from a pair of 733 MHz CPUs bought in

Some random ideas:
	- reinstall the slower, stable CPUs and burn the BIOS
		If you are a linux hacker then you kept these
		"just in case".. or else
	- get a loaner CPU and use it to burn the BIOS
		If you are a linux hacker then you have no
		life and no friends to get a loaner from but
		you do have a roomfull of computer parts...
		otherwise
	- install only one CPU, it may be more stable
	- run your CPU slower than spec, it may be more stable
		most microcode bugs are not timining sensitive
		but it is worth a try

Good luck.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
