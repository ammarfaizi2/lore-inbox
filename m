Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbUASUIz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 15:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbUASUIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 15:08:55 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:26793 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S262564AbUASUIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 15:08:55 -0500
Date: Mon, 19 Jan 2004 12:08:04 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jes Sorensen <jes@trained-monkey.org>, akpm@osdl.org
cc: linux-kernel@vger.kernel.org, jbarnes@sgi.com, steiner@sgi.com,
       torvalds@osdl.org
Subject: Re: [patch] increse MAX_NR_MEMBLKS to same as MAX_NUMNODES on NUMA
Message-ID: <4990000.1074542883@[10.10.2.4]>
In-Reply-To: <E1AiZ5h-00043I-00@jaguar.mkp.net>
References: <E1AiZ5h-00043I-00@jaguar.mkp.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Since we now support # of CPUs > BITS_PER_LONG with cpumask_t it would
> be nice to be able to support more than BITS_PER_LONG memory blocks.

Nothing uses them. We're probably better off just removing them altogether.

M.

