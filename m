Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262625AbUEWL57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262625AbUEWL57 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 07:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbUEWL57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 07:57:59 -0400
Received: from zero.aec.at ([193.170.194.10]:20229 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262625AbUEWL56 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 07:57:58 -0400
To: davids@webmaster.com
cc: "linux-kernel mailing list" <linux-kernel@vger.kernel.org>,
       <jbarnes@engr.sgi.com>
Subject: Re: How can I optimize a process on a NUMA architecture(x86-64
 specifically)?
References: <1Yma3-4cF-3@gated-at.bofh.it> <1YRnC-3vk-5@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sun, 23 May 2004 13:57:45 +0200
In-Reply-To: <1YRnC-3vk-5@gated-at.bofh.it> (David Schwartz's message of
 "Sun, 23 May 2004 05:00:12 +0200")
Message-ID: <m3d64vtkxy.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David Schwartz" <davids@webmaster.com> writes:

> 	I don't think we've reached the point yet where treating x86-64 systems as
> NUMA machines makes very much sense.

Benchmarks disagree with you on that. In most cases local memory
policy seems to work better than BIOS interleaving. That's because
memory latency is usually more important than memory bandwidth.

-Andi

