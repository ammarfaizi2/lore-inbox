Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290633AbSARTNp>; Fri, 18 Jan 2002 14:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290780AbSARTNf>; Fri, 18 Jan 2002 14:13:35 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30985 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290633AbSARTNV>; Fri, 18 Jan 2002 14:13:21 -0500
Subject: Re: vm philosophising
To: oxymoron@waste.org (Oliver Xymoron)
Date: Fri, 18 Jan 2002 19:23:47 +0000 (GMT)
Cc: riel@conectiva.com.br (Rik van Riel),
        bole@falcon.etf.bg.ac.yu (Bosko Radivojevic),
        J.A.K.Mouw@its.tudelft.nl (Erik Mouw),
        andrea@suse.de (Andrea Arcangeli), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0201181225090.31074-100000@waste.org> from "Oliver Xymoron" at Jan 18, 2002 12:39:54 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Rec7-0007fg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There is another VM that has a property that people would like:
> deterministically handling memory exhaustion. Unfortunately, that VM
> probably can't co-exist with over-commit and the performance gains that
> affords.

It can definitely co-exist. Overcommit control is just a book keeping
exercise on address space commits.
