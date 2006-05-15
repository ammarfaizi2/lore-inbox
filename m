Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWEOTKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWEOTKc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 15:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWEOTKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 15:10:31 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:15851 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S932317AbWEOTKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 15:10:30 -0400
Date: Mon, 15 May 2006 13:10:29 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: NFS readdir problem
Message-ID: <20060515191029.GY12272@parisc-linux.org>
References: <4ae3c140605150836i3f8d3890pa8568bf7d0431a7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ae3c140605150836i3f8d3890pa8568bf7d0431a7b@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2006 at 11:36:53AM -0400, Xin Zhao wrote:
> I use NFS to read a remote directory, which contains 56 entries. But
> after the read, "ls -al" only show 26, 31, or 51 entries in three test
> runs.
> 
> I have read the NFS  code "encode_entry" and related "nfs_readdir",
> "nfs3_proc_readdir"..., but haven't find the right place that can
> cause this problem.
> 
> Is there anyone has similar experience? Please help!

I don't know the answer ... but you could do a little more to help:

 - What's the server?
 - What's the client?
 - Exact versions of OS/kernel running on each

If you're really enthusiastic, you could run tcpdump and look at the
traces to see what filenames are actually being transported across.
