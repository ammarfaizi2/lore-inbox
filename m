Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933056AbWKMUFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933056AbWKMUFr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 15:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933058AbWKMUFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 15:05:47 -0500
Received: from sccrmhc11.comcast.net ([204.127.200.81]:8370 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S933056AbWKMUFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 15:05:46 -0500
Date: Mon, 13 Nov 2006 15:05:16 -0500
From: Tom Vier <tmv@comcast.net>
To: linux-kernel@vger.kernel.org
Subject: Re: XFS filesystem performance drop in kernels 2.6.16+
Message-ID: <20061113200516.GE32304@zero>
Reply-To: Tom Vier <tmv@comcast.net>
References: <bde600590611090930g3ab97aq3c76d7bca4ec267f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bde600590611090930g3ab97aq3c76d7bca4ec267f@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2006 at 08:30:23PM +0300, Igor A. Valcov wrote:
> I also noticed that I/O barriers were introduced in v2.6.16 and
> thought they may be the cause, but mounting the file system with
> 'nobarrier' doesn't seem to affect the performance in any way.

I don't know if it's related, but i played with a few fs'es a few months ago
and both xfs and reiser4 were very slow. iirc, they both took about 45min
longer than reiserfs and jfs to copy 70 or 80gigs of files from another
drive.

I suspected delayed allocation was the culprit (both r4 and xfs use DA).
Never really looked into it much, however.

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0x15741ECE
