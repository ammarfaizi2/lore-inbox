Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030433AbWFIT0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030433AbWFIT0B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 15:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030437AbWFIT0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 15:26:01 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:20891 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030433AbWFITZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 15:25:59 -0400
Message-ID: <4489CB42.6020709@garzik.org>
Date: Fri, 09 Jun 2006 15:25:54 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Alex Tomas <alex@clusterfs.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chase Venters <chase.venters@clientec.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Andreas Dilger <adilger@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>	<4488E1A4.20305@garzik.org>	<20060609083523.GQ5964@schatzie.adilger.int>	<44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>	<Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>	<m33beecntr.fsf@bzzz.home.net>	<Pine.LNX.4.64.0606090913390.5498@g5.osdl.org>	<Pine.LNX.4.64.0606090933130.5498@g5.osdl.org>	<20060609181020.GB5964@schatzie.adilger.int>	<Pine.LNX.4.64.0606091114270.5498@g5.osdl.org>	<m31wty9o77.fsf@bzzz.home.net>	<Pine.LNX.4.64.0606091137340.5498@g5.osdl.org>	<Pine.LNX.4.64.0606091347590.5541@turbotaz.ourhouse>	<1149880865.22124.70.camel@localhost.localdomain> <m3irna6sja.fsf@bzzz.home.net>
In-Reply-To: <m3irna6sja.fsf@bzzz.home.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas wrote:
>>>>>> Alan Cox (AC) writes:
> 
>  AC> Unfortunately in the software case if you want it in the base kernel you
>  AC> are bolting new manifolds on everyones car at once, and someone is going
>  AC> to have an engine explode as a result.
> 
> please, don't forget you need to enable it by mount option.

Irrelevant.  That's a development-only situation.  It will be enabled by 
default eventually, and should be considered in that light.

	Jeff



