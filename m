Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130765AbRBVEs7>; Wed, 21 Feb 2001 23:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130892AbRBVEst>; Wed, 21 Feb 2001 23:48:49 -0500
Received: from www.wen-online.de ([212.223.88.39]:30218 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130765AbRBVEsf>;
	Wed, 21 Feb 2001 23:48:35 -0500
Date: Thu, 22 Feb 2001 05:48:31 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Adam Schrotenboer <ajschrotenboer@lycosmail.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux ac20 patch got error:
In-Reply-To: <3A940B40.3020009@lycosmail.com>
Message-ID: <Pine.LNX.4.33.0102220543240.1500-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Feb 2001, Adam Schrotenboer wrote:

> A rather incomprehensible message, so let's flesh this out a bit.
>
> Basically the problem occurs when patching linux/fs/reiserfs/namei.c It
> can't find it, presumably due to an error in 2.4.1, where it appears to
> me that reiserfs/ is located off of linux/ not linux/fs/. Simple to fix,
> I guess, though this would appear to mean that Linus made a mistake w/
> 2.4.1 (plz correct me if I'm wrong), though it could also be said that
> this means that Alan diff'd the wrong tree (basically a fixed tree in re
> reiserfs/)

A third possibility: an elf/gremlin munged your tree for grins ;-)

ac20 went in clean here.

	-Mike

