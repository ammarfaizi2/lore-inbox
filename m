Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264972AbUFAKOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264972AbUFAKOf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 06:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264979AbUFAKOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 06:14:35 -0400
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:38667 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S264972AbUFAKOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 06:14:33 -0400
To: "Buddy Lumpkin" <b.lumpkin@comcast.net>
Cc: "'John Bradford'" <john@grabjohn.com>,
       "'Michael Brennan'" <mbrennan@ezrs.com>, <linux-kernel@vger.kernel.org>,
       <riel@redhat.com>
From: Tim Connors <tconnors+linuxkernel1086084622@astro.swin.edu.au>
Subject: Re:  why swap at all?
In-reply-to: <S264961AbUFAJhd/20040601093733Z+1483@vger.kernel.org>
References: <200405312029.i4VKTCZ0000596@81-2-122-30.bradfords.org.uk> <S264961AbUFAJhd/20040601093733Z+1483@vger.kernel.org>
X-Face: "0\RuOFb6AcQ}B_F/^%;;AmS%><zZ_q?N1w1%1voDY7#Ywj~qRaL7].8HB'2~pDUS|{E=$R\-s?;+p!RCe:w||kS\T@[(eQHB*-8u;~)ZP4;QYUI`|GJ)NS\`jLbW<e'R*y+Od,S5D+Vz++a<[$g'>"qr*^0t%eriBMe_x]B7&@b8_\i<A/A@T
Message-ID: <slrn-0.9.7.4-25709-3086-200406012010-tc@hexane.ssi.swin.edu.au>
Date: Tue, 1 Jun 2004 20:13:59 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Buddy Lumpkin" <b.lumpkin@comcast.net> said on Tue, 1 Jun 2004 02:38:42 -0700:
> If I know in advance that filesystem I/O will eventually fill physical
> memory with filesystem pages (pagecache), then why would I allow file system
> I/O to force out anonymous pages on the system? Also, why wake up an
> expensive algorithm (kswapd) that walks all pages in physical memory in
> order to determine which pages are "Least Recently Used" on a system where
...

Incidentally, what happens when kswapd becomes a zombie? I've seen
this a few times, and I am currently posting on a machine that has
been up for 15 days, and which oopsed 10 or so days ago (something to
do with nfs, but don't worry about that - the machine is running
2.4.20, and is not exactly up-to-date), killing kswapd.

But I don't notice anything at all different about how the system is
behaving. However, I haven't been doing much more than running emacs
and mozilla recently - I haven't been running my visualisation
software that typically stresses the VM beyond usefullness.

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
Whip me. Beat me. Make me maintain AIX.
