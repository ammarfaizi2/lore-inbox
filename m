Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290492AbSAQWQO>; Thu, 17 Jan 2002 17:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290488AbSAQWPz>; Thu, 17 Jan 2002 17:15:55 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:517 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290490AbSAQWPv>; Thu, 17 Jan 2002 17:15:51 -0500
Date: Thu, 17 Jan 2002 14:15:27 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.3-pre1] Fix NFS dentry lookup behaviour
In-Reply-To: <15430.14576.445228.537714@charged.uio.no>
Message-ID: <Pine.LNX.4.33.0201171414220.3114-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 17 Jan 2002, Trond Myklebust wrote:
>
>  - Close 'cto hole' when doing open(".").

What's wrong with using the existing "revalidate" approach? I hate the
notion of adding a special VFS layer call for something like this.

		Linus

