Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272756AbTHKQ3N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 12:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264448AbTHKQ3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:29:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:40070 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S272756AbTHKQ1C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 12:27:02 -0400
Message-Id: <5.2.1.1.2.20030811181759.019ffcf0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Mon, 11 Aug 2003 18:31:09 +0200
To: Con Kolivas <kernel@kolivas.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH]O14int
Cc: Martin Schlemmer <azarah@gentoo.org>, Nick Piggin <piggin@cyberone.com.au>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200308120033.32391.kernel@kolivas.org>
References: <1060610663.13256.76.camel@workshop.saharacpt.lan>
 <200308090149.25688.kernel@kolivas.org>
 <3F376597.9000708@cyberone.com.au>
 <1060610663.13256.76.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:33 AM 8/12/2003 +1000, Con Kolivas wrote:

>I'm trying to work on it I hope you can report exactly what your issue is and
>I'll try and address it. Do you really compile jobs make -j10 each time while
>using your machine? (rhetoric question of course since there is absolutely no
>advantage to doing that without lots of cpus). If not, how does it perform
>under your real world conditions?

Um, slight ~objection.

What's the difference between one tester running a make -j10 and 10 
students compiling their assignments in a multiuser box?  I test throughput 
with make -j30 on a 128Mb 500Mhz PIII, because I know for a very very many 
times measured fact that the box can handle this (heavy but _not_ extreme) 
load.  It's not the only load in the world, but it's such a dead simple 
load that the kernel dare not have difficulty with it IMHO.

         -Mike 

