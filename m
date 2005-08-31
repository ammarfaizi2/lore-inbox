Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbVHaAKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbVHaAKF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 20:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbVHaAKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 20:10:05 -0400
Received: from web53607.mail.yahoo.com ([206.190.37.40]:51132 "HELO
	web53607.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932298AbVHaAKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 20:10:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=cWavHbz4Xi1DrHTVF2i+79MaldMf2t6Y2yHFghj9adVdXvj+7z34MkFAvBL69F5FJ8f3MwHY2OAldD9wUjFrPOWS4a7M+PW+lvtB9Hb4TjGDLpTGowFLj4dNJrGWvX+EEMyx8fPLUUBGTvDwM4TvyZFd7nCL9WEhZ3orsqkT+gQ=  ;
Message-ID: <20050831000948.40799.qmail@web53607.mail.yahoo.com>
Date: Wed, 31 Aug 2005 10:09:48 +1000 (EST)
From: Steve Kieu <haiquy@yahoo.com>
Subject: Re: Very strange Marvell/Yukon Gigabit NIC networking problems
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Jesse Brandeburg <jesse.brandeburg@gmail.com>,
       Daniel Drake <dsd@gentoo.org>, Steve Kieu <haiquy@yahoo.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20050830152908.1dc24339@dxpl.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Stephen Hemminger <shemminger@osdl.org> wrote:

> On Wed, 31 Aug 2005 07:49:37 +1000 (EST)

> > 
> > install-8_23.tar.bz2
> 
> Just look for references to CHIP_REV_YU_LITE_A3 in
> the driver
> 	sk98lin/skgeinit.c and sk98lin/skxmac2.c
> The comparison should always be:

Have a look but no clue to patch it, there are one
instance of comparing

> 	pAC->GIni.GIChipRev >= CHIP_REV_YU_LITE_A3
> otherwise it will not correctly take chip out of
> powerdown (coma) mode.

please send me a patch to the install-8_23.tar.bz2
then I can test. Or intruct more details, which line
and what should change then I can do manually.

I have nerver done device driver programming in my
life!



> 


S.KIEU

Send instant messages to your online friends http://au.messenger.yahoo.com 
