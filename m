Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264363AbTFCAdV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 20:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264374AbTFCAdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 20:33:20 -0400
Received: from main.gmane.org ([80.91.224.249]:42447 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264363AbTFCAdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 20:33:20 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Pasi Savolainen <psavo@iki.fi>
Subject: Re: [BENCHMARK] 2.5.70-mm2 with contest
Date: Tue, 3 Jun 2003 00:44:26 +0000 (UTC)
Message-ID: <bbgr1a$bfn$1@main.gmane.org>
References: <200306030806.49885.kernel@kolivas.org> <20030602151644.06252b28.akpm@digeo.com>
X-Complaints-To: usenet@main.gmane.org
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@digeo.com>:
>> I tried getting runs on 2.5.69-mm9 and 2.5.70-mm1 but ran into BUGs that have 
>> been reported before on lkml.
> 
> mm3 should be OK.  After several days more testing I have not found any
> bugs in mm3's ext3 which are not already in 2.5.70 ;)

I've hit assertion() /fs/jbd/transaction.c:1115 several times. Can't
tell anything else, as immediately after this keyboard gets locked, X still
reacts on _mouse_ (copy/paste thing) , but probably after hitting
disk/filesystem every application locks. for example cpu load meter
which open-read /proc gets frozen right away.
/var/log/messages doesn't tell a thing. Seems random.

kernel 2.5.70-mm3.

-- 
   Psi -- <http://www.iki.fi/pasi.savolainen>

