Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293342AbSBZBid>; Mon, 25 Feb 2002 20:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292631AbSBZBi0>; Mon, 25 Feb 2002 20:38:26 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19208 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293335AbSBZBhm>; Mon, 25 Feb 2002 20:37:42 -0500
Subject: Re: 2.4.19-preX: What we really need: -AA patches finally in the        tree
To: Martin.Bligh@us.ibm.com (Martin J. Bligh)
Date: Tue, 26 Feb 2002 01:51:48 +0000 (GMT)
Cc: spstarr@sh0n.net (Shawn Starr), linux-kernel@vger.kernel.org (Linux)
In-Reply-To: <4360000.1014687125@flay> from "Martin J. Bligh" at Feb 25, 2002 05:32:06 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16fWmT-0007B6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> rmap still sucks on large systems though. I'd love to see rmap
> in the main kernel, but it needs to get the scalability fixed first.
> The main problem seems to be pagemap_lru_lock ... Rik & crew 
> know about this problem, but let's give them some time to fix it 
> before rmap gets put into mainline ....

It needs to works with page tables in highmem too
