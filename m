Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318536AbSGZWQq>; Fri, 26 Jul 2002 18:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318538AbSGZWQq>; Fri, 26 Jul 2002 18:16:46 -0400
Received: from mm02snlnto.sandia.gov ([132.175.109.21]:22026 "HELO
	mm02snlnto.sandia.gov") by vger.kernel.org with SMTP
	id <S318536AbSGZWQp>; Fri, 26 Jul 2002 18:16:45 -0400
X-Server-Uuid: 95b8ca9b-fe4b-44f7-8977-a6cb2d3025ff
Message-ID: <B51F0C636E578A4E832D3958690CD73E0BA72309@es04snlnt>
From: "Dandini, Michael A" <madandi@sandia.gov>
To: linux-kernel@vger.kernel.org
Subject: Question about  importing symbols
Date: Fri, 26 Jul 2002 16:19:59 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-Filter-Version: 1.8 (sass2426)
X-WSS-ID: 115F15DF4857271-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am currently trying to develop a kernel module and I am having problems
getting insmod to resolve all the symbols.  The one I'm haveing particular
trouble with is tcp_v4_lookup_listener.  It's extern'd in tcp.h and is
exported in netsyms.c, yet when I do a ksyms -a it doesn't show up.  I've
got a feeling I'm missing something either when I compile my module, or I
didn't pick the right options when I compiled my kernel.

Any thoughts?

Michael A. Dandini
Sandia National Laboratories
madandi@sandia.gov

