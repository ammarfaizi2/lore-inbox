Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267341AbUHYO5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267341AbUHYO5M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 10:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267184AbUHYO5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 10:57:11 -0400
Received: from jade.spiritone.com ([216.99.193.136]:60035 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S267594AbUHYOzk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 10:55:40 -0400
Date: Wed, 25 Aug 2004 07:55:34 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Message-ID: <150920000.1093445730@[10.10.2.4]>
In-Reply-To: <200408242233.55583.gene.heskett@verizon.net>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408232308.41244.gene.heskett@verizon.net> <20040825014937.GC15901@zero> <200408242233.55583.gene.heskett@verizon.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This whole thread makes me think ... if we oops, shouldn't we check if
we're holding any spinlocks or semaphores, and just panic the whole
machine if so? Not sure how expensive it would be to hold that state,
but ...

M.

