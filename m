Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284240AbRLYBBL>; Mon, 24 Dec 2001 20:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284242AbRLYBBB>; Mon, 24 Dec 2001 20:01:01 -0500
Received: from mail49-s.fg.online.no ([148.122.161.49]:19594 "EHLO
	mail49.fg.online.no") by vger.kernel.org with ESMTP
	id <S284240AbRLYBAr>; Mon, 24 Dec 2001 20:00:47 -0500
Message-Id: <200112250100.CAA00400@mail49.fg.online.no>
Content-Type: text/plain; charset=US-ASCII
From: Svein Ove Aas <svein@crfh.dyndns.org>
Reply-To: svein.ove@aas.no
To: linux-kernel@vger.kernel.org
Subject: Re: IDE CDROM locks the system hard on media error
Date: Tue, 25 Dec 2001 02:00:44 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <E16IeVp-0005XP-00@the-village.bc.nu>
In-Reply-To: <E16IeVp-0005XP-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> So we should set ATAPI devices on the PIIX4 to non DMA modes ?

Setting it to mdma2 fixes the problem on my system, and there is no slowdown 
whatsoever. (Due to its already slow speed?)

It would have to be verified by someone with a faster device than mine, but 
right now there doesn't seem to be any downside.
