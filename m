Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261689AbSJNOSD>; Mon, 14 Oct 2002 10:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261690AbSJNOSD>; Mon, 14 Oct 2002 10:18:03 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:32269 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261689AbSJNOSC>; Mon, 14 Oct 2002 10:18:02 -0400
Date: Mon, 14 Oct 2002 15:23:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Derrick J Brashear <shadow@dementia.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: AFS system call registration function (was Re: Two fixes for 2.4.19-pre5-ac3)
Message-ID: <20021014152353.A16334@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Derrick J Brashear <shadow@dementia.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.3.96L.1021013214541.5586B-100000@scully.trafford.dementia.org> <Pine.LNX.3.96L.1021013215608.5586C-100000@scully.trafford.dementia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.96L.1021013215608.5586C-100000@scully.trafford.dementia.org>; from shadow@dementia.org on Sun, Oct 13, 2002 at 09:58:00PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2002 at 09:58:00PM -0400, Derrick J Brashear wrote:
> The version we have now uses long, so... (read on)

I know..

> we have people with deployed utilities which call the afs system call,
> because, well, it's the AFS system call. it would be good to maintain
> compatibility with those, which means we should
> a) keep using the same system call if we can
> b) if so, keep using "long".


AFS is currently not in mainline.  You request a new feature, in this
case an optional syscall that only was reserved previously.  In
general we don|t merge random stuff asis in the kernel just because it
happens to exist.  There is no reason you canb't add a sane API
for openafs 1.3

