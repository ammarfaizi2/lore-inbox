Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291614AbSBHPjN>; Fri, 8 Feb 2002 10:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291616AbSBHPjD>; Fri, 8 Feb 2002 10:39:03 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2320 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291614AbSBHPiy>; Fri, 8 Feb 2002 10:38:54 -0500
Subject: Re: [patch] larger kernel stack (8k->16k) per task
To: tigran@veritas.com (Tigran Aivazian)
Date: Fri, 8 Feb 2002 15:52:15 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, hugh@veritas.com (Hugh Dickins)
In-Reply-To: <Pine.LNX.4.33.0202081511400.1359-100000@einstein.homenet> from "Tigran Aivazian" at Feb 08, 2002 03:20:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ZDJv-00044a-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It is against 2.4.9 but should be easy to port in any direction. (One way
> the patch could be improved is by making the size CONFIG_ option instead
> of hardcoding). Oh btw, please don't tell me "but now you'd need _four_
> physically-contiguous pages to create a task instead of two!" because I
> know it (and think it's not too bad).

As a debugging tool its ok. Adding 8K to the kernel stack size
is a wonderful way to eat huge amounts of RAM though.
