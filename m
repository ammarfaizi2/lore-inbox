Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276249AbRJ2Qac>; Mon, 29 Oct 2001 11:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276312AbRJ2QaZ>; Mon, 29 Oct 2001 11:30:25 -0500
Received: from peace.netnation.com ([204.174.223.2]:33805 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP
	id <S276249AbRJ2QaJ>; Mon, 29 Oct 2001 11:30:09 -0500
Date: Mon, 29 Oct 2001 08:30:44 -0800
From: Simon Kirby <sim@netnation.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops: Quota race in 2.4.12?
Message-ID: <20011029083044.G17389@netnation.com>
In-Reply-To: <20011028215818.A7887@netnation.com> <20011029144441.E11994@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <20011029144441.E11994@atrey.karlin.mff.cuni.cz>; from jack@suse.cz on Mon, Oct 29, 2001 at 02:44:41PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2001 at 02:44:41PM +0100, Jan Kara wrote:

>   I'd also blame some SMP locking (I think that on UP everything was tested well) but
> everything should be protected by lock_kernel() and it seems to me that everything really
> is protected. Anyway I'll try to find the problem.

I notice you just recently posted a patch to fix possible list
corruption.  Could this be related?

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
