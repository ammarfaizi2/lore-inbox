Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271717AbTHRMwu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 08:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271715AbTHRMwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 08:52:49 -0400
Received: from mccormic.mcs.gac.edu ([138.236.64.149]:2467 "EHLO
	mccormic.mcs.gac.edu") by vger.kernel.org with ESMTP
	id S271717AbTHRMwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 08:52:46 -0400
Date: Mon, 18 Aug 2003 07:52:35 -0500
Message-Id: <200308181252.h7ICqZh8003767@mccormic.mcs.gac.edu>
From: Max Hailperin <max@gustavus.edu>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
In-reply-to: <20030818110001.6564.64238.Mailman@lists.us.dell.com>
	(linux-kernel-daily-digest-request@lists.us.dell.com)
Subject: Re: [RFC] Re: Blender profiling-1 O16.2int
References: <20030818110001.6564.64238.Mailman@lists.us.dell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Con Kolivas <kernel@kolivas.org>
   To: Voluspa <voluspa@comhem.se>
   Subject: [RFC] Re: Blender profiling-1 O16.2int
   Date: Sun, 17 Aug 2003 23:36:42 +1000
   Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
      Mike Galbraith <efault@gmx.de>, Andrew Morton <akpm@osdl.org>,
      William Lee Irwin III <wli@holomorphy.com>

   ... I do have some ideas about how to progress with this (some Mike
   has suggested to me previously), but so far most of them involve
   some detriment to the interactive performance on other apps. So I'm
   appealing to others for ideas.

   Comments?

   Con

I suggest you put a small limit on the number of times that a task can
be requeued onto the active array before it needs to go to the expired
array.  -max
