Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751406AbWHDBG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbWHDBG5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 21:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbWHDBG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 21:06:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40373 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751406AbWHDBG4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 21:06:56 -0400
Date: Thu, 3 Aug 2006 18:03:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Nate Diller" <nate.diller@gmail.com>
Cc: "Adrian Bunk" <bunk@stusta.de>, "Jens Axboe" <axboe@suse.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] [1/2] Remove Deadline I/O scheduler
Message-Id: <20060803180337.a7f89a17.akpm@osdl.org>
In-Reply-To: <5c49b0ed0608031715l7e8f9c7dyd647a11c44c73400@mail.gmail.com>
References: <5c49b0ed0608031557n405196ack3fa2024aae8a9475@mail.gmail.com>
	<20060803234648.GK25692@stusta.de>
	<5c49b0ed0608031715l7e8f9c7dyd647a11c44c73400@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2006 17:15:47 -0700
"Nate Diller" <nate.diller@gmail.com> wrote:

> My goal is not to get
> deadline removed, but a discussion with Andrew some months ago showed
> he was averse to creating more options than we already have.

hm, we must have miscommunicated here.

The way to handle the elevator scheduler is to just add it as a new feature
not touch deadline.

Leter (and it might be over a year) we might decide to remove deadline. 
But the cost of carrying it is veyr low.

