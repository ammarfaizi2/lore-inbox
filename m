Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbTFJUA7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 16:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbTFJT7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 15:59:21 -0400
Received: from auemail2.lucent.com ([192.11.223.163]:55451 "EHLO
	auemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S262283AbTFJT63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 15:58:29 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16102.15170.653446.711973@gargle.gargle.HOWL>
Date: Tue, 10 Jun 2003 16:10:42 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: Andrew Morton <akpm@digeo.com>
Cc: "John Stoffel" <stoffel@lucent.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Zwane Mwaikambo <zwane@holomorphy.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.5.70-mm3 - Oops and hang
In-Reply-To: <20030610123732.562e7b22.akpm@digeo.com>
References: <16101.55819.768909.143767@gargle.gargle.HOWL>
	<20030610123732.562e7b22.akpm@digeo.com>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew> This appears to be a visitation from the Great Unsolved Bug of
Andrew> the 2.5 series.  Someone playing with a freed task_struct.

Ouch, not a good thing.

Andrew> Correct me if I'm wrong, but this has only ever been seen with
Andrew> CONFIG_PREEMPT=y?

I can't say, but I'm willing to apply patches to see if I can help
track it down.  I'm about to put -mm7 up on my machine and let that
run for a while.  

Is there anything special you want me to do to stress this out?

John
