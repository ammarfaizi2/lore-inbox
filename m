Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317471AbSHaPCq>; Sat, 31 Aug 2002 11:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317520AbSHaPCp>; Sat, 31 Aug 2002 11:02:45 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:29939
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317471AbSHaPCp>; Sat, 31 Aug 2002 11:02:45 -0400
Subject: Re: [patch 2.5.31] transparent PCI-to-PCI bridges
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020831144223.A772@localhost.park.msu.ru>
References: <20020831015716.B926@jurassic.park.msu.ru>
	<20020830201958.24112@192.168.4.1> 
	<20020831144223.A772@localhost.park.msu.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 31 Aug 2002 16:06:42 +0100
Message-Id: <1030806402.3490.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Related question while we are on the subject of bridges. I'm trying to
work out a clean way to initialize a new subtree of devices given a
bridge that suddenely has devices behind it.

This occurs in three cases I know about now 
- Easidock cardbus->PCI extender
- IBM Thinkpad hot docking bridge
- Magma PCI extended split bridge


