Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932748AbWEXRxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932748AbWEXRxR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 13:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932752AbWEXRxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 13:53:17 -0400
Received: from sccrmhc11.comcast.net ([204.127.200.81]:23484 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932748AbWEXRxQ (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 24 May 2006 13:53:16 -0400
Date: Wed, 24 May 2006 13:53:12 -0400
From: Tom Vier <tmv@comcast.net>
To: Hans Reiser <reiser@namesys.com>
Cc: Linux-Kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       Reiserfs mail-list <Reiserfs-List@namesys.com>
Subject: Re: [PATCH] updated reiser4 - reduced cpu usage for writes by writing more than 4k at a time (has implications for generic write code and eventually for the IO layer)
Message-ID: <20060524175312.GA3579@zero>
Reply-To: Tom Vier <tmv@comcast.net>
References: <44736D3E.8090808@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44736D3E.8090808@namesys.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2006 at 01:14:54PM -0700, Hans Reiser wrote:
> underlying FS can be improved.  Performance results show that the new
> code consumes  40% less CPU when doing "dd bs=1MB ....." (your hardware,
> and whether the data is in cache, may vary this result).  Note that this
> has only a small effect on elapsed time for most hardware.

Write requests in linux are restricted to one page?

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0x15741ECE
