Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279609AbRJ2Xfu>; Mon, 29 Oct 2001 18:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279616AbRJ2Xfl>; Mon, 29 Oct 2001 18:35:41 -0500
Received: from pizda.ninka.net ([216.101.162.242]:62355 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S279609AbRJ2Xfc>;
	Mon, 29 Oct 2001 18:35:32 -0500
Date: Mon, 29 Oct 2001 15:36:03 -0800 (PST)
Message-Id: <20011029.153603.45720857.davem@redhat.com>
To: bcrl@redhat.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: please revert bogus patch to vmscan.c
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011029183315.I25434@redhat.com>
In-Reply-To: <20011029181527.G25434@redhat.com>
	<Pine.LNX.4.33.0110291522490.16656-100000@penguin.transmeta.com>
	<20011029183315.I25434@redhat.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Benjamin LaHaise <bcrl@redhat.com>
   Date: Mon, 29 Oct 2001 18:33:16 -0500
   
   Sure.  But do it correctly and perform a tlb flush higher up in the page 
   table walking code.  Just deleting it entirely is bogus.  Introducing 
   hard to track down bugs is just stupid.
   
It isn't a bug, the referenced bit is a heuristic.  The referenced bit
being wrong cannot result in corrupted user memory.

Franks a lot,
David S. Miller
davem@redhat.com
