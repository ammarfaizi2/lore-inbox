Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265008AbTAPAnB>; Wed, 15 Jan 2003 19:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265475AbTAPAnB>; Wed, 15 Jan 2003 19:43:01 -0500
Received: from host217-35-54-97.in-addr.btopenworld.com ([217.35.54.97]:4992
	"EHLO dstc.edu.au") by vger.kernel.org with ESMTP
	id <S265008AbTAPAnA>; Wed, 15 Jan 2003 19:43:00 -0500
Message-Id: <200301160051.AAA09861@tereshkova.dstc.edu.au>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counting bug in svc_tcp_recvfrom causes panic for TCP NFS 
In-reply-to: Your message of Wed, 15 Jan 2003 15:28:44 PST. 
	<20030115152844.6a66cd0f.akpm@digeo.com> 
References: <200301152254.WAA19810@tereshkova.dstc.edu.au>  <20030115152844.6a66cd0f.akpm@digeo.com> 
Date: Thu, 16 Jan 2003 00:51:47 +0000
From: Ted Phelps <phelps@dstc.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton may have said:
> Ted Phelps <phelps@dstc.edu.au> wrote:
> >
> > Perhaps a better solution would be to change page_address() to be
> > consistently be a function for all memory layouts.
> 
> Assuredly.  How about this?

It no only makes sense and looks good, but it works too!

Thanks,
-Ted
