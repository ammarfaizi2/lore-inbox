Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263120AbUDESRM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 14:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263124AbUDESRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 14:17:12 -0400
Received: from mail.shareable.org ([81.29.64.88]:1944 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S263120AbUDESRK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 14:17:10 -0400
Date: Mon, 5 Apr 2004 19:17:07 +0100
From: Jamie Lokier <jamie@shareable.org>
To: bero@arklinux.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Catching SIGSEGV with signal() in 2.6
Message-ID: <20040405181707.GA21245@mail.shareable.org>
References: <Pine.LNX.4.58.0404050824310.13367@build.arklinux.oregonstate.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0404050824310.13367@build.arklinux.oregonstate.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bero@arklinux.org wrote:
> ... doesn't seem to be possible anymore.
> 
> See http://www.openoffice.org/issues/show_bug.cgi?id=27162
> 
> Is this change intentional, or a bug?

On 2.6.3, x86, SIGSEGV is being caught just fine in my test program,
with the correct fault address, with or without SA_SIGINFO.

-- Jamie
