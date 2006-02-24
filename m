Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWBXMPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWBXMPW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 07:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWBXMPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 07:15:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64433 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932121AbWBXMPV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 07:15:21 -0500
Date: Fri, 24 Feb 2006 04:14:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: bfink@eventmonitor.com, linux-kernel@vger.kernel.org
Subject: Re: NFS Still broken in 2.6.x?
Message-Id: <20060224041435.733b4f0d.akpm@osdl.org>
In-Reply-To: <1140734824.7963.38.camel@lade.trondhjem.org>
References: <43FE1CAD.3050806@eventmonitor.com>
	<1140734824.7963.38.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
> On Thu, 2006-02-23 at 15:35 -0500, Bryan Fink wrote:
>  > Hi All.  I'm running into a bit of trouble with NFS on 2.6.  I see that
>  > at least Trond thought, mid-January, that "The readahead algorithm has
>  > been broken in 2.6.x for at least the past 6 months." (
>  > http://www.ussg.iu.edu/hypermail/linux/kernel/0601.2/0559.html) Anyone
>  > know if that has been fixed?
> 
>  No it hasn't been fixed. ...and no, this is not a problem that only
>  affects NFS: it just happens to give a more noticeable performance
>  impact due to the larger latency of NFS over a 100Mbps link.

iirc, last time we went round this loop Ram and I were unable to reproduce it.

Does anyone have a testcase?
