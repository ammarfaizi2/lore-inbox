Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266385AbUAOA1O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 19:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266387AbUAOA1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 19:27:14 -0500
Received: from mail.ccur.com ([208.248.32.212]:11789 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S266385AbUAOA1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 19:27:11 -0500
Date: Wed, 14 Jan 2004 19:27:03 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Paul Jackson <pj@sgi.com>
Cc: Paul Mackerras <paulus@samba.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
Message-ID: <20040115002703.GA20971@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20040107165607.GA11483@rudolph.ccur.com> <20040107113207.3aab64f5.akpm@osdl.org> <20040108051111.4ae36b58.pj@sgi.com> <16381.57040.576175.977969@cargo.ozlabs.ibm.com> <20040108225929.GA24089@tsunami.ccur.com> <16381.61618.275775.487768@cargo.ozlabs.ibm.com> <20040114150331.02220d4d.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040114150331.02220d4d.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 03:03:31PM -0800, Paul Jackson wrote:
> Joe - question - is there any good reason not to use Paul M's
> suggestion, eor'ing the index with 1 on 64 bit big endian hardware?
> I have a patch about ready (as soon as I can get time on my big system
> to test it) that uses the eor 1 idea.

In principle it should work fine.  The details will be in the code
of course.

I've been working on-and-off on fixing the equivalent endian problem
in __mask_parse_len.  How is that part going for you?  I haven't yet
decided if I want to post it.

-- 
"Money can buy bandwidth, but latency is forever" -- John Mashey
Joe
