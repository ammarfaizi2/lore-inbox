Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264984AbUGSQjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264984AbUGSQjA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 12:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264997AbUGSQjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 12:39:00 -0400
Received: from bay19-f31.bay19.hotmail.com ([64.4.53.81]:30738 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264984AbUGSQi7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 12:38:59 -0400
X-Originating-IP: [216.150.62.136]
X-Originating-Email: [monetic@hotmail.com]
From: "Lucas Jackson" <monetic@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6 pagesize, block size limits?
Date: Mon, 19 Jul 2004 10:38:58 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY19-F31m7yvgffuVF00053e0d@hotmail.com>
X-OriginalArrivalTime: 19 Jul 2004 16:38:58.0376 (UTC) FILETIME=[E39E5C80:01C46DAE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm planning on upgrading a RH AS3 2.4.21 kernel to 2.6.7 on an AMD Opteron 
box (2 CPU), for use with oracle 10g.
I know 2.4 had a pagesize of something like 4k (?)..i'm wondering how this 
changes in 2.6 on a 64-bit box? I'm wanting to use XFS with 16kb stripes 
(direct and async io, if possible), and am hoping i won't hit some kind of 
kernel limit that's gonna bottleneck that for me.
I don't plan on using a raw device either.

Thanx,

-Tony

_________________________________________________________________
Is your PC infected? Get a FREE online computer virus scan from McAfee® 
Security. http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963

