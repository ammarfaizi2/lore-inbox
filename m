Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261278AbSKBPhY>; Sat, 2 Nov 2002 10:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261281AbSKBPhY>; Sat, 2 Nov 2002 10:37:24 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:7097 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S261278AbSKBPhX>;
	Sat, 2 Nov 2002 10:37:23 -0500
Date: Sat, 2 Nov 2002 15:43:50 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Colin Burnett <cburnett@fractal.candysporks.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: file change notification
Message-ID: <20021102154350.GB4402@bjl1.asuk.net>
References: <1036186261.3dc2f2959a2a0@www.candysporks.org> <20021101141927.A16607@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021101141927.A16607@figure1.int.wirex.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Colin Burnett (cburnett@fractal.candysporks.org) wrote:
> > Is there notification to processes on file change?
> 
> have you looked at dnotify? Documentation/dnotify.txt

dnotify is better than file notification if you're monitoring a lot of
files in a directory which change rarely.  On the other hand it's
quite bad if you're monitoring a few files and other files in the
directory are changing often.

Still, it works.

-- Jamie
