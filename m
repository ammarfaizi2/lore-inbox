Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263626AbUHWLpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbUHWLpX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 07:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbUHWLpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 07:45:23 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:58040 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S263626AbUHWLpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 07:45:16 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 23 Aug 2004 13:44:11 +0200
To: schilling@fokus.fraunhofer.de, christer@weinigel.se
Cc: tonnerre@thundrix.ch, linux-kernel@vger.kernel.org
Subject: Re: DTrace-like analysis possible with future Linux kernels?
Message-ID: <4129D88B.nailA9B2DZO92@burner>
References: <2vipq-7O8-15@gated-at.bofh.it>
 <2vj2b-8md-9@gated-at.bofh.it> <2vDtS-bq-19@gated-at.bofh.it>
 <E1ByXMd-00007M-4A@localhost> <412770EA.nail9DO11D18Y@burner>
 <412889FC.nail9MX1X3XW5@burner>
 <Pine.LNX.4.58.0408221450540.297@neptune.local>
 <m37jrr40zi.fsf@zoo.weinigel.se> <20040822192646.GH19768@thundrix.ch>
 <4128FE94.nail9U42DA799@burner> <20040822203321.GI19768@thundrix.ch>
 <4129055F.nail9V911J6JH@burner> <m3hdqu3ldc.fsf@zoo.weinigel.se>
In-Reply-To: <m3hdqu3ldc.fsf@zoo.weinigel.se>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christer Weinigel <christer@weinigel.se> wrote:

> It depends on your definition of "a few k" :-)
>
>     http://elks.sourceforge.net/
>
> It will run fine on an 8086 with 512 kBytes of RAM, but I its possible
> to get by with as little as 200kByte of RAM.

But this would not be a UNIX system... (see my other mail).

> I work with embedded Linux systems and the standard configuration for
> the stuff I do is with a small embedded processor such as the Motorola
> MPC860 or the Axis Etrax 100 (about as fast as an i486) and 8MByte of
> RAM and 4MByte of flash.  It's really no problem running in 2MByte of
> RAM and 2MByte of flash but then the system really just does one thing
> such as initializing a routing table and then routing data back and
> forth.  To be able to get OpenSSL running in there and so on I really
> need 8MByte of RAM.

If you don't try to run fancy stuff (like a GUI), I am sure that Solaris
will run with a machine that has something between 2 and 4 MB of RAM.

Note that if you design new embedded hardware, you typically think in
units of 16 MB.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
