Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265270AbSKUTvt>; Thu, 21 Nov 2002 14:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267014AbSKUTvt>; Thu, 21 Nov 2002 14:51:49 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:63229 "EHLO
	flossy.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S265270AbSKUTvq>; Thu, 21 Nov 2002 14:51:46 -0500
Date: Thu, 21 Nov 2002 15:00:28 -0500
From: Doug Ledford <dledford@redhat.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: David Zaffiro <davzaffiro@netscape.net>, linux-kernel@vger.kernel.org
Subject: Re: Compiling x86 with and without frame pointer
Message-ID: <20021121200028.GG14063@redhat.com>
Mail-Followup-To: Willy Tarreau <willy@w.ods.org>,
	David Zaffiro <davzaffiro@netscape.net>,
	linux-kernel@vger.kernel.org
References: <19005.1037854033@kao2.melbourne.sgi.com> <20021121050607.GA1554@mark.mielke.cc> <3DDCA7C9.9040501@netscape.net> <20021121192045.GE3636@alpha.home.local> <20021121193231.GE14063@redhat.com> <20021121194127.GA22442@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021121194127.GA22442@alpha.home.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 08:41:27PM +0100, Willy Tarreau wrote:
> Yes, you're quite right about this. I had my mind obsessed all the day reducing
> a bzImage to fit it on a diskette, and didn't immediately realise that other
> people were speaking pure vmlinux in this discussion :-)

I had thought about that as well, but then my answer was that if the 
space is that important on the floppy, then we (meaning Red Hat) could 
compile out BOOT kernel with whatever option gave the smallest compressed 
image and compile installed kernels with whatever gave actual best 
performance (with a + given to kernels that have a frame pointer in the 
event of a tie or insignificant performance difference).

Of course you may be talking about a system that always boots from floppy 
and sits in some closet for years or some embedded system where that 4k in 
flash is super important, so situational decision rules apply ;-)

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
