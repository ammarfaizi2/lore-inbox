Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264875AbSKJOTA>; Sun, 10 Nov 2002 09:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264880AbSKJOTA>; Sun, 10 Nov 2002 09:19:00 -0500
Received: from host194.steeleye.com ([66.206.164.34]:63242 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S264875AbSKJOTA>; Sun, 10 Nov 2002 09:19:00 -0500
Message-Id: <200211101425.gAAEPeO01862@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Zwane Mwaikambo <zwane@holomorphy.com>
cc: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5] notsc option needs some attention/TLC 
In-Reply-To: Message from Zwane Mwaikambo <zwane@holomorphy.com> 
   of "Sun, 10 Nov 2002 00:32:33 EST." <Pine.LNX.4.44.0211100031400.10475-100000@montezuma.mastecende.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 10 Nov 2002 09:25:39 -0500
From: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zwane@holomorphy.com said:
> <n00b> How does one go about building a kernel with PIT y and TSC y ?
> My  current kernels obviously are incapable of disabling the TSC </
> n00b> 

The PIT patches come with the voyager stuff (which isn't integrated yet).  
However, they are broken out at

http://linux-voyager.bkbits.net/timer-2.5

if you have bitkeeper.

On a current kernel, if you build with TSC n, it should have the same effect.

James


