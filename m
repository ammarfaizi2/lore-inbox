Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVEPA5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVEPA5x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 20:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVEPA5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 20:57:53 -0400
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:9610 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261205AbVEPA5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 20:57:51 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17031.61437.279517.139691@wombat.chubb.wattle.id.au>
Date: Mon, 16 May 2005 10:57:33 +1000
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Need kernel patch to compile with Intel compiler
In-Reply-To: <1115933336l.8448l.0l@werewolf.able.es>
References: <377362e105051207461ff85b87@mail.gmail.com>
	<Pine.LNX.4.61.0505121130030.31719@chaos.analogic.com>
	<1115933336l.8448l.0l@werewolf.able.es>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "J" == J A Magallon <J.A.> writes:

J> On 05.12, Richard B. Johnson wrote:
>> On Thu, 12 May 2005, Tetsuji "Maverick" Rai wrote:
>> 
>> > In this mailing list archive I found a discussion on how to
>> compile > kenrel 2.6.x with Intel C++ compiler, but it was a bit
>> old, and only > kernel patch for version 2.6.5 or around so can be
>> found.  As mine is > HT enabled, I want newer one.
>> >

>> Why would you even attempt to convert the kernel sources to be
>> compiled with some other tools? Also C++ won't work because the
>> kernel is all about method, i.e., procedures. You need a procedural
>> compiler for most of it, not an object-oriented one.

J> Intel's is a C/C++/Fortran compiler.

J> Last time I checked (a year or so ago) gcc catched the intel
J> compiler for equivalent options, or say it the other way, adjusting
J> gcc options you could get more or less the same performance. There
J> were even places where gcc generated faster code than icc. And that
J> was gcc-3.0.x, I think.

For IA64, the intel compiler generates *much* better code than gcc.
Depending on the source, you can get factor of two or better,
particularly for crypto code like rc4.

-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
