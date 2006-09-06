Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751641AbWIFQgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbWIFQgq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 12:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751636AbWIFQgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 12:36:45 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:29770 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751629AbWIFQgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 12:36:43 -0400
Message-ID: <44FEF90E.1050407@oracle.com>
Date: Wed, 06 Sep 2006 09:36:30 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: suparna@in.ibm.com
CC: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/5] dio: clean up completion phase of direct_io_worker()
References: <20060905235732.29630.3950.sendpatchset@tetsuo.zabbo.net> <20060906073643.GA27784@in.ibm.com>
In-Reply-To: <20060906073643.GA27784@in.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> code more maintainable (I hope/wish we could also do something similar with
> simplifying the locking as well).

I agree, and that is definitely on my medium-term todo list.

> Of course with this code, we have to await rigorous testing
> ... and more reviews, but please consider this as my ack for the approach.

Yeah, absolutely.  Is there a chance that IBM can throw some testing
cycles at it?  I have it queued up for some moderately sized DB runs
over here (FC arrays, cable pulling, that kind of thing.)

- z
