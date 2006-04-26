Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbWDZSpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWDZSpN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 14:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbWDZSpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 14:45:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47557 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932361AbWDZSpL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 14:45:11 -0400
Date: Wed, 26 Apr 2006 11:47:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, npiggin@suse.de,
       linux-mm@kvack.org
Subject: Re: Lockless page cache test results
Message-Id: <20060426114737.239806a2.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604261130450.19587@schroedinger.engr.sgi.com>
References: <20060426135310.GB5083@suse.de>
	<20060426095511.0cc7a3f9.akpm@osdl.org>
	<20060426174235.GC5002@suse.de>
	<20060426111054.2b4f1736.akpm@osdl.org>
	<Pine.LNX.4.64.0604261130450.19587@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> On Wed, 26 Apr 2006, Andrew Morton wrote:
> 
> > OK.  That doesn't sound like something which a real application is likely
> > to do ;)
> 
> A real application scenario may be an application that has lots of threads 
> that are streaming data through multiple different disk channels (that 
> are able to transfer data simultanouesly. e.g. connected to different 
> nodes in a NUMA system) into the same address space.
> 
> Something like the above is fairly typical for multimedia filters 
> processing large amounts of data.

>From the same file?

To /dev/null?
