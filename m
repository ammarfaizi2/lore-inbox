Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264032AbRFXKSV>; Sun, 24 Jun 2001 06:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264096AbRFXKSL>; Sun, 24 Jun 2001 06:18:11 -0400
Received: from smtp8.xs4all.nl ([194.109.127.134]:4835 "EHLO smtp8.xs4all.nl")
	by vger.kernel.org with ESMTP id <S264032AbRFXKSE>;
	Sun, 24 Jun 2001 06:18:04 -0400
Date: Sun, 24 Jun 2001 12:18:00 +0200 (CEST)
From: Seth Mos <knuffie@xs4all.nl>
To: Daniel Stone <daniel@sfarc.net>
cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [OOPS] XFS in large Maildir
In-Reply-To: <20010624175139.A19220@kabuki.sfarc.net>
Message-ID: <Pine.BSI.4.10.10106241216500.12216-100000@xs4.xs4all.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jun 2001, Daniel Stone wrote:

> Hi guys,
> I've attached the ksymoops output from Linux 2.4.6-pre3-xfs (CVS tree from
> some point). I'll try an update now, but when I try to access stuff in
> ~/Maildir/netfilter/cur (~7k files in it), XFS just OOPSes. The OOPS I
> attached was from mutt, but it also successfully hangs ls, so I doubt it's a
> mutt bug.

Have you tried running xfs_repair -n on the filesystem to see if something
is wrong? Was the kernel compiled with 2.96-?? of 2.91.66?


