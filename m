Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270223AbTGSOoR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 10:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270263AbTGSOoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 10:44:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63411 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S270223AbTGSOoP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 10:44:15 -0400
Message-ID: <3F195CB5.6050407@pobox.com>
Date: Sat, 19 Jul 2003 10:59:01 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: David Howells <dhowells@redhat.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] General filesystem cache
References: <Pine.LNX.4.44.0307182000300.6370-100000@home.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0307182000300.6370-100000@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Fri, 18 Jul 2003, David Howells wrote:
> 
>>Here's a patch to add a quasi-filesystem ("CacheFS") that turns a block device
>>into a general cache for any other filesystem that cares to make use of its
>>facilities.
>>
>>This is primarily intended for use with my AFS filesystem, but I've designed
>>it such that it needs to know nothing about the filesystem it's backing, and
>>so it may also be useful for NFS, SMB and ISO9660 for example.
> 
> 
> Ok. Sounds good. In fact, it's something I've wanted for a while, since 
> it's also potentially the solution to performance-critical things like 
> virtual filesystems based on revision control logic etc (traditionally 
> done with fake NFS servers).


I've been pushing David to keep it general enough to work for NFS, which 
has been a long term goal of mine...  (and it appears my nagging worked)

Thanks David!

	Jeff



