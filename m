Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269190AbUJFOWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269190AbUJFOWp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 10:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269248AbUJFOWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 10:22:45 -0400
Received: from mx.laposte.net ([81.255.54.11]:34801 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S269190AbUJFOWn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 10:22:43 -0400
Date: Wed,  6 Oct 2004 16:22:42 +0200
Message-Id: <I562LU$B5322C82B32CD312671903B7D99A7EBB@laposte.net>
Subject: Re: [patch] sched: auto-tuning task-migration
MIME-Version: 1.0
X-Sensitivity: 3
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
From: "emmanuel\.fuste" <emmanuel.fuste@laposte.net>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
X-XaM3-API-Version: 4.1 (B51)
X-type: 0
X-SenderIP: 127.0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>the following patch adds a new feature to the scheduler:
during >bootup
>it measures migration costs and sets up cache_hot value
>accordingly.
>
>The measurement is point-to-point, i.e. it can be used to measure
>the
>migration costs in cache hierarchies - e.g. by NUMA setup
code. >The
>patch prints out a matrix of migration costs between CPUs. 
>(self-migration means pure cache dirtying cost)

Hi Ingo,

Is your auto-tunig patch is supposed to work on a shared L2
cache arch like my i586 SMP system ?
Just to know.

Thanks.

E.F.


Accédez au courrier électronique de La Poste : www.laposte.net ; 
3615 LAPOSTENET (0,34€/mn) ; tél : 08 92 68 13 50 (0,34€/mn)



