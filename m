Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266223AbUHVGAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266223AbUHVGAL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 02:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266233AbUHVGAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 02:00:11 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:53414 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266223AbUHVGAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 02:00:02 -0400
Subject: Re: [patch] context-switching overhead in X, ioport(), 2.6.8.1
From: Lee Revell <rlrevell@joe-job.com>
To: Ryan Cumming <ryan@spitfire.gotdns.org>
Cc: "David S. Miller" <davem@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200408212242.33562.ryan@spitfire.gotdns.org>
References: <20040821135516.GA3872@elte.hu>
	 <20040821214632.62d58e40.davem@redhat.com>
	 <200408212242.33562.ryan@spitfire.gotdns.org>
Content-Type: text/plain
Message-Id: <1093154401.817.43.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 22 Aug 2004 02:00:02 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-22 at 01:42, Ryan Cumming wrote:
> On Saturday 21 August 2004 21:46, David S. Miller wrote:
> > FWIW, I would recommend a sparse bitmap implementation for the
> > ioport stuff.
> 
> The problem is that the sparse bitmap would have to be unpacked to the "dense" 
> bitmap that lives in the TSS on context switch.

Can someone supply a link to the original LKML post with the ioport
change?  I was not able to find it in my mailbox nor in the archives.

Lee

