Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266308AbSLCVcy>; Tue, 3 Dec 2002 16:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266298AbSLCVcy>; Tue, 3 Dec 2002 16:32:54 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:31906 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266308AbSLCVcx>; Tue, 3 Dec 2002 16:32:53 -0500
Subject: Re: Reserving physical memory at boot time
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: root@chaos.analogic.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200212031352.37405.baldrick@wanadoo.fr>
References: <Pine.LNX.3.95.1021203160658.20996A-100000@chaos.analogic.com> 
	<200212031352.37405.baldrick@wanadoo.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Dec 2002 22:14:25 +0000
Message-Id: <1038953665.11439.113.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-03 at 12:52, Duncan Sands wrote:
> > If you need a certain page reserved at boot-time you are out-of-luck.
> 
> I don't mind modifying the kernel.

Makes it easier to mark pages - look at how the e820 code works and mark
the page in question reserved as it does. 

