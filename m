Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318991AbSIDAFY>; Tue, 3 Sep 2002 20:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318992AbSIDAFY>; Tue, 3 Sep 2002 20:05:24 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:13502 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S318991AbSIDAFX>; Tue, 3 Sep 2002 20:05:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: Thunder from the hill <thunder@lightweight.ods.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c
Date: Wed, 4 Sep 2002 02:08:22 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Thunder from the hill <thunder@lightweight.ods.org>,
       Hacksaw <hacksaw@hacksaw.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209031600140.3373-100000@hawkeye.luckynet.adm>
In-Reply-To: <Pine.LNX.4.44.0209031600140.3373-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <17mNlP-13yuauC@fmrl03.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 4. September 2002 00:03 schrieb Thunder from the hill:
> Hi,
>
> On 3 Sep 2002, Alan Cox wrote:
> > If you have a good raid card then you can do online resizing, volume
> > allocation, volume format changing, volume migration etc. For those
> > cases you have to get the journalling right in order to be able to do
> > that kind of thing properly
>
> That's true, if you use partitions. I don't see the problem.

No, it's always a problem. You need to record somewhere, what you
use which disk for. If these recordings need to be changeable
on a live system, you need to make sure that they are always in a
consistent state.

	Regards
		Oliver
