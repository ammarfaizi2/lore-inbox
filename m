Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQL0Q4C>; Wed, 27 Dec 2000 11:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129210AbQL0Qzw>; Wed, 27 Dec 2000 11:55:52 -0500
Received: from [193.120.224.170] ([193.120.224.170]:52358 "EHLO
	florence.itg.ie") by vger.kernel.org with ESMTP id <S129183AbQL0Qzn>;
	Wed, 27 Dec 2000 11:55:43 -0500
Date: Wed, 27 Dec 2000 16:23:43 +0000 (GMT)
From: Paul Jakma <paulj@itg.ie>
To: Ian Stirling <root@mauve.demon.co.uk>
cc: Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: Abysmal RAID 0 performance on 2.4.0-test10 for IDE?
In-Reply-To: <200012261952.TAA11390@mauve.demon.co.uk>
Message-ID: <Pine.LNX.4.30.0012271620530.24075-100000@rossi.itg.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Dec 2000, Ian Stirling wrote:

> The PCI bus can move around 130MB/sec,

in bursts yes, but sustained data bandwidth of PCI is a lot lower,
maybe 30 to 50MB/s. And you won't get sustained RAID performance >
sustained PCI performance.

> Anyway, in clarification, Rik mentioned that two reads from different
> disk (arrays?) on the same controller at the same time get more or less
> the same speed.

try scsi.

--paulj

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
