Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262537AbRENWhp>; Mon, 14 May 2001 18:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262540AbRENWhf>; Mon, 14 May 2001 18:37:35 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:1808 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S262537AbRENWhY>; Mon, 14 May 2001 18:37:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andreas Dilger <adilger@turbolinux.com>
Subject: Re: [PATCH][CFT] (updated) ext2 directories in pagecache
Date: Tue, 15 May 2001 00:23:36 +0200
X-Mailer: KMail [version 1.2]
Cc: Andreas Dilger <adilger@turbolinux.com>,
        Linux kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <200105142004.f4EK4oRr002055@webber.adilger.int>
In-Reply-To: <200105142004.f4EK4oRr002055@webber.adilger.int>
MIME-Version: 1.0
Message-Id: <01051500233602.24410@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 May 2001 22:04, Andreas Dilger wrote:
> Maybe we can have a "noindex" mount option for this?

We need that regardless, I just keep forgetting to put it in.  I assume 
the semantics are obvious: no new indexes are created but existing ones 
are maintained.  I.e., -o noindex does not mean 'seek out and destroy 
all indexes'.

--
Daniel
