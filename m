Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbUL1Naw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUL1Naw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 08:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbUL1Naw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 08:30:52 -0500
Received: from p4.ensae.fr ([83.145.66.202]:43130 "EHLO PC809.ensae.fr")
	by vger.kernel.org with ESMTP id S261184AbUL1Nat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 08:30:49 -0500
From: Guillaume =?iso-8859-15?q?Lac=F4te?= <Linux@glacote.com>
Reply-To: Linux@glacote.com
To: linux-kernel@vger.kernel.org
Subject: Areca ARC-1120 Raid6 card - did they borrow raid6int.uc ?
Date: Tue, 28 Dec 2004 14:30:46 +0100
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412281430.46839.Linux@glacote.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom's Hardware reviews a RAID6 hardware board:
http://www.tomshardware.com/storage/20041227/areca-raid6-01.html#raid_level_6_array_in_detail

I have no idea of wether the computation of the P and Q syndromes are standard 
and well-known or not in the industry. I only know of Peter Anvin's 
implementation:
http://kernel.org/pub/linux/kernel/people/hpa/raid6.pdf

My question is: if they are not, since it seems from the picture at Tom's that 
Areca may have a similar implementation, did they borrow code ?

