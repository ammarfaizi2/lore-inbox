Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269454AbUIZAaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269454AbUIZAaA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 20:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269452AbUIZA3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 20:29:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41697 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269454AbUIZA2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 20:28:39 -0400
Date: Sat, 25 Sep 2004 20:28:30 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Masao Fukuchi <fukuchi.masao@jp.fujitsu.com>
cc: linux-scsi@vger.kernel.org, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC]transient transport error report for LLD timeout
In-Reply-To: <200409232332.AA03619@fukuchi.jp.fujitsu.com>
Message-ID: <Pine.LNX.4.44.0409252026210.28582-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2004, Masao Fukuchi wrote:

> We are now planning to use linux for enterprise system.
> In enterprise system, response time is important factor and it requires 
> response time within 30sec even if hardware(software) fails.

Makes some sense, I guess.  However it could lead to
spurious IO errors under high load since some disk
arrays are known to take longer than 10 seconds to
finish an IO operation under extremely heavy loads.

I'm not convinced that enterprise systems need latency
more than reliability, but maybe that's ust me ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

