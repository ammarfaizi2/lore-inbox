Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266171AbRGGNlH>; Sat, 7 Jul 2001 09:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266169AbRGGNk5>; Sat, 7 Jul 2001 09:40:57 -0400
Received: from logger.gamma.ru ([194.186.254.23]:48145 "EHLO logger.gamma.ru")
	by vger.kernel.org with ESMTP id <S266166AbRGGNkr>;
	Sat, 7 Jul 2001 09:40:47 -0400
To: linux-kernel@vger.kernel.org
Path: pccross!not-for-mail
From: crosser@average.org (Eugene Crosser)
Newsgroups: linux.kernel
Subject: Re: [Acpi] Re: ACPI fundamental locking problems
Date: 7 Jul 2001 17:37:52 +0400
Organization: Average
Message-ID: <9i73bg$psv$1@pccross.average.org>
In-Reply-To: <Pine.GSO.4.21.0107070727030.24836-100000@weyl.math.psu.edu>
Mime-Version: 1.0
X-Newsreader: knews 0.9.8
X-Comment-To: Alexander Viro <viro@math.psu.edu>
Content-Type: text/plain; charset=koi8-r
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.GSO.4.21.0107070727030.24836-100000@weyl.math.psu.edu>,
        Alexander Viro <viro@math.psu.edu> writes:

>> Doesn't the approach "treat a chunk of data built into bzImage as
>> populated ramfs" look cleaner?  No need to fiddle with tar format,
>> no copying data from place to place.
> 
> What the hell _is_ "populated ramfs"? The thing doesn't live in array
> of blocks. Its directory structure consists of a bunch of dentries.

I am stupid.  But the point still stays: having an image of pre-populated
filesystem (some other than ramfs) that you only need to load into
RAM seems more sutable than parsing tar format.  Maybe (probably) I am
missing something.

Eugene
