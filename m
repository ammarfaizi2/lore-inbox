Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264772AbUEaUVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264772AbUEaUVz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 16:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264773AbUEaUVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 16:21:55 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:10368 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264772AbUEaUVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 16:21:54 -0400
Date: Mon, 31 May 2004 21:29:12 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200405312029.i4VKTCZ0000596@81-2-122-30.bradfords.org.uk>
To: Michael Brennan <mbrennan@ezrs.com>, linux-kernel@vger.kernel.org
In-Reply-To: <40BB88B5.8080300@ezrs.com>
References: <40BB88B5.8080300@ezrs.com>
Subject: Re: why swap at all?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Quote from Michael Brennan <mbrennan@ezrs.com>:
> Hi!
> I've recently started to follow this list.
> I read the swap discussion here, and I was wondering about what Nick 
> Pigging said about grepping the kernel tree.
> 
> Nick Piggin wrote:
>  > For example, I have 57MB swapped right now. It allows me to instantly
>  > grep the kernel tree. If I turned swap off, each grep would probably
>  > take 30 seconds.
> 
> Are the pages swapped to disk as a result of the grep run?

I'm not really sure what the above was intended to demonstrate, but I assume
that it was that having swap allowed the first grep to fill physical RAM with
cache at the expense of swapping other processes, which were using physical
RAM to disk.

However, if 57 Mb of swap allows this, 57 Mb of extra physical RAM should also
also allow the grep to be cached, without having to swap out anything.

Hence my comment about it not being a magical property of swap space.

John.
