Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263399AbTJESHY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 14:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263406AbTJESHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 14:07:24 -0400
Received: from intra.cyclades.com ([64.186.161.6]:27785 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263399AbTJESHX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 14:07:23 -0400
Date: Sun, 5 Oct 2003 15:01:57 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Maciej Zenczykowski <maze@cela.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swap and 2.4.20
In-Reply-To: <Pine.LNX.4.44.0310051559340.5605-100000@gaia.cela.pl>
Message-ID: <Pine.LNX.4.44.0310051459560.1408-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 5 Oct 2003, Maciej Zenczykowski wrote:

> > I remember Linus ranting about swap at one point, but it's been a while.
> > 
> > What is the current state of the need for swap on a linux kernel, 2.4.20 in 
> > specific. Does it need *any*, given some reasonable amount of RAM? What 
> > constitutes a reasonable of RAM?
> > 
> > My recent experience suggest none is needed.
> 
> I have a different - slightly academic - question.  Is it possible to turn
> off swapping? (not turn off swap)  Ie. to prevent the kernel from
> unloading paged-in read-only executables?  I realise this is a tough
> question with mmap being used for many other things besides executables...

No. Paged-in clean pages might be removed from memory at any time and
reread upon access.


