Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129801AbQK1VHm>; Tue, 28 Nov 2000 16:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130007AbQK1VHW>; Tue, 28 Nov 2000 16:07:22 -0500
Received: from dystopia.lab43.org ([209.217.122.210]:37384 "EHLO
        dystopia.lab43.org") by vger.kernel.org with ESMTP
        id <S129801AbQK1VHR>; Tue, 28 Nov 2000 16:07:17 -0500
Date: Tue, 28 Nov 2000 15:36:57 -0500 (EST)
From: Rod Stewart <stewart@lab43.org>
To: Keith Owens <kaos@ocs.com.au>
cc: Kurt Garloff <garloff@suse.de>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: modutils-2.3.21: modprobe looping 
In-Reply-To: <3301.975443633@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.21.0011281535540.12642-100000@dystopia.lab43.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 29 Nov 2000, Keith Owens wrote:
> On Tue, 28 Nov 2000 20:22:59 +0100, 
> Kurt Garloff <garloff@suse.de> wrote:
> >Find attached the modules.dep that caused this: There is a circular
> >dependency of pppoe on pppox on pppoe on ....
> 
> The kernel code is broken.  Circular dependencies make no sense, the
> pppoe maintainer agrees and I thought that bug was fixed.

It is fixed in test10/11.

-Rms

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
