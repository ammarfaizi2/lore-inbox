Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbTL2BY4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 20:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbTL2BY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 20:24:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:48780 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262174AbTL2BYz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 20:24:55 -0500
Date: Sun, 28 Dec 2003 17:24:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 journel aborted in 2.6.0-mm1
Message-Id: <20031228172450.413cfa5c.akpm@osdl.org>
In-Reply-To: <3FEF5E53.1080203@wmich.edu>
References: <3FEF5E53.1080203@wmich.edu>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Sweetman <ed.sweetman@wmich.edu> wrote:
>
> Not sure what the cause of this type of error is but i've only seen it 
> in the very late test releases of 2.6.0 and now in the mm1 patch (i've 
> always used the mm branch of the test releases).  It seems to like to 
> happen to my partition that has /var/ on it during an updatedb and log 
> rotate that is standard practice in most distributions. I'm using debian 
>   unstable if that helps narrow the problem down, however it seems more 
> likely to be a kernel problem possibly in one of the patches that's been 
> in mm's tree for very recent test, and now release, kernels.
> 

I'd need to see the kernel logs at the time when the abort happens.

An internal filesystem inconsistency will certainly cause this.  Force a
fsck.

