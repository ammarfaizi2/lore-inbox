Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946517AbWKJMBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946517AbWKJMBj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 07:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946518AbWKJMBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 07:01:39 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:50081 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1946517AbWKJMBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 07:01:38 -0500
Date: Fri, 10 Nov 2006 12:59:59 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Eric Sandeen <sandeen@sandeen.net>
cc: "Igor A. Valcov" <viaprog@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com
Subject: Re: XFS filesystem performance drop in kernels 2.6.16+
In-Reply-To: <4553F3C6.2030807@sandeen.net>
Message-ID: <Pine.LNX.4.61.0611101259490.6068@yvahk01.tjqt.qr>
References: <bde600590611090930g3ab97aq3c76d7bca4ec267f@mail.gmail.com>
 <4553F3C6.2030807@sandeen.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I also noticed that I/O barriers were introduced in v2.6.16 and
>> thought they may be the cause, but mounting the file system with
>> 'nobarrier' doesn't seem to affect the performance in any way.
>
>
> did this happen to be a remount with nobarrier, or a fresh mount?

For the barrier stuff, see
http://lkml.org/lkml/2006/5/19/33


	-`J'
-- 
