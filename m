Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318332AbSGRTfv>; Thu, 18 Jul 2002 15:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318334AbSGRTfu>; Thu, 18 Jul 2002 15:35:50 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:47094 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318332AbSGRTfu>; Thu, 18 Jul 2002 15:35:50 -0400
Subject: Re: [PATCH] strict VM overcommit for stock 2.4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Love <rml@tech9.net>
Cc: root@chaos.analogic.com, Szakacsits Szabolcs <szaka@sienet.hu>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <1027020179.1085.150.camel@sinai>
References: <Pine.LNX.3.95.1020718150735.1373A-100000@chaos.analogic.com> 
	<1027020179.1085.150.camel@sinai>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 18 Jul 2002 21:49:21 +0100
Message-Id: <1027025361.9727.41.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Same issue with HA etc... its not preventing OOM so much as being
> prepared for it, by pushing the failures into the allocation routines
> and out from the page access.
> 
> Certainly Alan and RedHat found a need for it, too.  It should be pretty
> clear why this is an issue...

The code was written initially because we had large customers with a
direct requirement for the facility. It is also very relevant to
embedded systems where you want controlled failure.

