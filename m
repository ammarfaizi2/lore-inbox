Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131947AbRBKI5q>; Sun, 11 Feb 2001 03:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131980AbRBKI5g>; Sun, 11 Feb 2001 03:57:36 -0500
Received: from www.wen-online.de ([212.223.88.39]:23812 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S131947AbRBKI51>;
	Sun, 11 Feb 2001 03:57:27 -0500
Date: Sun, 11 Feb 2001 09:56:17 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Rik van Riel <riel@conectiva.com.br>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.1-ac7
In-Reply-To: <Pine.Linu.4.10.10102110701300.723-100000@mikeg.weiden.de>
Message-ID: <Pine.Linu.4.10.10102110954140.944-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Feb 2001, Mike Galbraith wrote:

> Something else I see while watching it run:  MUCH more swapout than
> swapin.  Does that mean we're sending pages to swap only to find out
> that we never need them again?

(numbers might be more descriptive)

user  :       0:07:21.70  54.3%  page in :   142613
nice  :       0:00:00.00   0.0%  page out:   155454
system:       0:03:40.63  27.1%  swap in :    56334
idle  :       0:02:30.50  18.5%  swap out:   149872
uptime:       0:13:32.83         context :   519726

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
