Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265316AbTLHDSP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 22:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265317AbTLHDSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 22:18:15 -0500
Received: from secure.comcen.com.au ([203.23.236.73]:62735 "EHLO
	xavier.etalk.net.au") by vger.kernel.org with ESMTP id S265316AbTLHDSF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 22:18:05 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: linux-kernel@vger.kernel.org
Subject: Re: Catching NForce2 lockup with NMI watchdog - found?
Date: Mon, 8 Dec 2003 13:21:06 +1000
User-Agent: KMail/1.5.1
Cc: ross@datscreative.com.au, recbo@nishanet.com,
       B.Zolnierkiewicz@elka.pw.edu.pl
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312081321.06692.ross@datscreative.com.au>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 of December 2003 04:08, Bob wrote: 
 > >>Sounds great.. maybe you have come across something. Yes, the CPU 
 > >>Disconnect function arrived in your BIOS in revision of 2003/03/27 
 > >>"6.Adds"CPU Disconnect Function" to adjust C1 disconnects. The Chipset 
 > >>does not support C2 disconnect; thus, disable C2 function." 
 > >> 
 > >>For me though.. Im on an ASUS A7N8X Deluxe v2 BIOS 1007. From what I can 
 > >>see the CPU Disconnect isnt even in the Uber BIOS 1007 for this ASUS 
 > >>that has been discussed. 
 > >> 
 > >>Craig 
 > >
 > >I don't have that in MSI K7N2 MCP2-T near the 
 > >agp and fsb spread spectrum items or anywhere 
 >> else. 
>Use athcool: 
>         http://members.jcom.home.ne.jp/jacobi/linux/softwares.html#athcool 
> or apply kernel patch (2.4 and 2.6 versions were posted already). 
>--bart 

Please take a look at 

Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered

in mailing list.

I approached it from another angle regarding delaying the apic ack in local timer irq
and achieved stability. It would be good to have others try it. Ian Kumlien is also
reporting success so far.
 
