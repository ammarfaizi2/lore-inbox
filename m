Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277071AbRJHSbu>; Mon, 8 Oct 2001 14:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277068AbRJHSbk>; Mon, 8 Oct 2001 14:31:40 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25872 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277065AbRJHSbe>; Mon, 8 Oct 2001 14:31:34 -0400
Subject: Re: low-latency patches
To: akpm@zip.com.au (Andrew Morton)
Date: Mon, 8 Oct 2001 19:36:09 +0100 (BST)
Cc: george@mvista.com (george anzinger), helgehaf@idb.hist.no (Helge Hafting),
        mfedyk@matchmail.com (Mike Fedyk), linux-kernel@vger.kernel.org
In-Reply-To: <3BC1EF61.9ECD3273@zip.com.au> from "Andrew Morton" at Oct 08, 2001 11:24:33 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qfG5-0001Sy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Right.  It needs to be a conscious, planned decision:  "from now on,
> holding a lock for more than 500 usecs is a bug".

Firstly you can start with "of course some hardware will stall the bus
longer than that"
