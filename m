Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286265AbRLJN6s>; Mon, 10 Dec 2001 08:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286269AbRLJN6j>; Mon, 10 Dec 2001 08:58:39 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8712 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286261AbRLJN6W>; Mon, 10 Dec 2001 08:58:22 -0500
Subject: Re: mm question
To: volodya@mindspring.com
Date: Mon, 10 Dec 2001 14:07:39 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.20.0112100844210.17065-100000@node2.localnet.net> from "volodya@mindspring.com" at Dec 10, 2001 08:47:58 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16DR5n-00028k-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It does not have to be contiguous. I was thinking of simply starting with 
> the smallest address and trying to free the pages until the needed amount 
> is available. But I have no idea how to properly do locking or force the
> page to be swapped out or something. 

You can simply get_free_page() 300K of pages. However you can't land them
in a given band other than the existing "below 16Mb" "below 4Gb" "anywhere"
bands.

Alan
