Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267300AbSLKVbW>; Wed, 11 Dec 2002 16:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267307AbSLKVbV>; Wed, 11 Dec 2002 16:31:21 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:59566 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S267300AbSLKVbV>; Wed, 11 Dec 2002 16:31:21 -0500
Date: Wed, 11 Dec 2002 13:38:57 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 Changes doc update.
Message-ID: <20021211213857.GC585@nic1-pc.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20021211172559.GA8613@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021211172559.GA8613@suse.de>
User-Agent: Mutt/1.4i
Organization: Oracle Corporation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Dave,
	First, thanks for a very useful document. I have one comment below:

On Wed, Dec 11, 2002 at 05:25:59PM +0000, Dave Jones wrote:
> Internal filesystems.
> ~~~~~~~~~~~~~~~~~~~~~
> /proc/filesystems will contain several filesystems that are not
> mountable in userspace, but are used internally by the kernel
> to keep track of things. These filesystems are futexfs, eventpollfs
> and hugetlbfs

I don't believe hugetlbfs is an "internal filesystem"... Last time I
checked, it was supposed to be mounted from userspace, and was intended for
use in that context...
	--Mark

--
Mark Fasheh
Software Developer, Oracle Corp
mark.fasheh@oracle.com
