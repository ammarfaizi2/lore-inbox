Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317305AbSH0VKj>; Tue, 27 Aug 2002 17:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317326AbSH0VKj>; Tue, 27 Aug 2002 17:10:39 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:31811 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S317305AbSH0VKi>;
	Tue, 27 Aug 2002 17:10:38 -0400
Date: Tue, 27 Aug 2002 23:14:55 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Yedidyah Bar-David <didi@tau.ac.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: updating the partition table of a busy drive
Message-ID: <20020827211455.GA7081@win.tue.nl>
References: <20020827005254.A20617@soul.math.tau.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020827005254.A20617@soul.math.tau.ac.il>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 12:52:54AM +0300, Yedidyah Bar-David wrote:

> Currently, any change to a partition table of a busy drive is
> practically delayed to the next reboot. Even things trivial as
> changing the type of an unmounted partition do not work, if
> another partition on that drive is mounted (or swapped to, etc.).

The type of a partition has no significance to the kernel.
So how can you say that changing the type doesnt work?

There are ioctls to tell a running kernel where you would like
to see partitions, entirely independent of the current disk contents.

Andries
