Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319024AbSIDC5T>; Tue, 3 Sep 2002 22:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319026AbSIDC5Q>; Tue, 3 Sep 2002 22:57:16 -0400
Received: from holomorphy.com ([66.224.33.161]:56482 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S319024AbSIDC5P>;
	Tue, 3 Sep 2002 22:57:15 -0400
Date: Tue, 3 Sep 2002 19:54:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ed Tomlinson <tomlins@cam.org>
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.33-mm1
Message-ID: <20020904025438.GV888@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ed Tomlinson <tomlins@cam.org>, Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
References: <3D7437AC.74EAE22B@zip.com.au> <3D755E2D.7A6D55C6@zip.com.au> <20020904011503.GT888@holomorphy.com> <200209032255.43198.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <200209032255.43198.tomlins@cam.org>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 3, 2002 09:15 pm, William Lee Irwin III wrote:
>> William Lee Irwin III <wli@holomorphy.com>
[something must have gotten snipped]

On Tue, Sep 03, 2002 at 10:55:43PM -0400, Ed Tomlinson wrote:
> What are the numbers telling you?  Is you test faster or slower
> with slablru?  Does it page more or less?  Is looking at the number
> of objects the way to determine if slablru is helping?  I submit
> the paging and runtimes are much better indications?  What do
> story do they tell?

Everything else is pretty much fine-tuning. Prior to this there was
zero control exerted over the things. Now it's much better behaved
with far less "swapping while buttloads of instantly reclaimable slab
memory is available" going on. Almost no swapping out of user memory
in favor of bloated slabs.

It's really that binary distinction that's most visible.


Cheers,
Bill
