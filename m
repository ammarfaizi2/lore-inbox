Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbVLCSRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbVLCSRR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 13:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbVLCSRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 13:17:17 -0500
Received: from host9.apollohosting.com ([209.239.47.119]:26825 "EHLO
	host9.apollohosting.com") by vger.kernel.org with ESMTP
	id S932102AbVLCSRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 13:17:16 -0500
From: "Larry Bates" <lbates@syscononline.com>
To: <linux-kernel@vger.kernel.org>
Subject: newbie - mdadm create raid1 mirrors on large drives
Date: Sat, 3 Dec 2005 12:17:15 -0600
Message-ID: <002501c5f835$cb6bec50$1e00a8c0@LABWXP>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20051203175355.GL31395@stusta.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hope this is the correct list for this question.

I've just recently begun using mdadm to set up some
arrays using large drives (300-400Gb).  One of the 
things I don't understand is this: when you first 
create a raid1 (mirrored) array from two drives 
mdadm insists on mirroring the contents of the first
drive to the second even though the drives are
entirely blank (e.g. new drives don't have anything
on them).  In one configuration I have, this takes
about 16 hours on a 400Gb drive.  When I do 5 of them
simultaneously this takes 2+ days to complete.  Is 
there some way to tell mdadm that you want to create 
a mirrored set but skip this rather long initial 
mirroring process?  I don't really see that it actually
accomplishes anything.

Thanks in advance for your assistance.

-Larry Bates


