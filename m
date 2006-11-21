Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030910AbWKUNLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030910AbWKUNLR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 08:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030930AbWKUNLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 08:11:17 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:4066 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1030910AbWKUNLQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 08:11:16 -0500
Date: Tue, 21 Nov 2006 14:09:26 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andrew Morton <akpm@osdl.org>
cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] WorkStruct: Shrink work_struct by two thirds
In-Reply-To: <20061120111712.5e399d12.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0611211409030.17055@yvahk01.tjqt.qr>
References: <20061120142713.12685.97188.stgit@warthog.cambridge.redhat.com>
 <20061120111712.5e399d12.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 20 2006 11:17, Andrew Morton wrote:
>struct work_struct {
>	union {
>		struct work_struct_lite w;
>		struct {
>			unsigned long pending;
>			struct list_head entry;
>			void (*func)(void *);
>			void *data;
>			void *wq_data;
>		};
>	}
         ^

+;  ;-)

>	struct timer_list timer;
>};
>

	-`J'
-- 
