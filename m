Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277900AbRJXOoN>; Wed, 24 Oct 2001 10:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275265AbRJXOoD>; Wed, 24 Oct 2001 10:44:03 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:4620 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S278537AbRJXOn4>; Wed, 24 Oct 2001 10:43:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: David Lang <david.lang@digitalinsight.com>
Subject: Re: VM
Date: Wed, 24 Oct 2001 16:44:53 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Keith Owens <kaos@ocs.com.au>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0110230911110.12990-100000@dlang.diginsite.com>
In-Reply-To: <Pine.LNX.4.40.0110230911110.12990-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011024144423Z16306-698+146@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On October 23, 2001 06:14 pm, David Lang wrote:
> Daniel, I think the suggestion isn't to break out the differences in a
> bunch of config options, but rather to do something like duplicating all
> files that are VM related into two files, foo.c becomes foo.aa.c and
> foo.rik.c at that point your config file either uses all the .rik files or
> all the .aa files and both would be in the same tree, but not interact
> with each other.
> 
> yes, there would be a lot of duplication between them, but something like
> this would let people compare the two directly without also having all the
> other linus vs ac changes potentially affecting their tests.

Patch and lilo are your friends.

--
Daniel
