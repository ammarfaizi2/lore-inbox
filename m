Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318720AbSHQUEk>; Sat, 17 Aug 2002 16:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318722AbSHQUEk>; Sat, 17 Aug 2002 16:04:40 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:31474 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318720AbSHQUEk>; Sat, 17 Aug 2002 16:04:40 -0400
Subject: Re: IDE?  IDE-TNG driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Matthew D. Pitts" <mpitts@suite224.net>
Cc: Skip Ford <skip.ford@verizon.net>, Andre Hedrick <andre@linux-ide.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <001301c24602$16a842c0$d942b0d1@pcs686>
References: <20020817115243.GA13771@merlin.emma.line.org>
	<Pine.LNX.4.10.10208170455050.23171-100000@master.linux-ide.org>
	<200208171356.g7HDut8I000305@pool-141-150-241-241.delv.east.verizon.net> 
	<001301c24602$16a842c0$d942b0d1@pcs686>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 17 Aug 2002 21:07:29 +0100
Message-Id: <1029614849.4809.44.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can do the switch (one way only right now) in 2.4.20-pre2-ac3.
Ultimately for 2.4 I want to get to the point where open() tries to
switch between srfoo and hdfoo and locks out the other user. For 2.5 we
can get more esoteric. 2.4 has to continue to just work

