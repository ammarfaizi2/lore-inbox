Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263026AbUC2QIw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 11:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262823AbUC2QIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 11:08:52 -0500
Received: from mail4.speakeasy.net ([216.254.0.204]:58026 "EHLO
	mail4.speakeasy.net") by vger.kernel.org with ESMTP id S263138AbUC2QBR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 11:01:17 -0500
Message-Id: <6.0.1.1.0.20040329085820.0293aec0@no.incoming.mail>
X-Mailer: QUALCOMM Windows Eudora Version 6.0.1.1
Date: Mon, 29 Mar 2004 09:01:10 -0700
To: Tomasz Rola <rtomek@cis.com.pl>
From: Jeff Woods <Kazrak+kernel@cesmail.net>
Subject: Re: who is merlin.fit.vutbr.cz?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1040329151755.5234B-100000@pioneer.space.nem
 esis.pl>
References: <200403290108.i2T18T8d024595@work.bitmover.com>
 <Pine.LNX.3.96.1040329151755.5234B-100000@pioneer.space.nemesis.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 3/29/2004 03:32 PM +0200, Tomasz Rola wrote:
>BTW, if I understand correctly, to read something from the tree one 
>doesn't really need to lock it. Only writes should be locked.

Locking on reads prevents getting a copy of the tree with half of someone 
else's changes that were written during your read.  That gets more likely 
as the time it takes to read the entire tree increases.

--
Jeff Woods <kazrak+kernel@cesmail.net> 


