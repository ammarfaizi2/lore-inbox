Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267057AbUBSJPW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 04:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267077AbUBSJPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 04:15:22 -0500
Received: from elin.scali.no ([62.70.89.10]:57319 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id S267057AbUBSJPQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 04:15:16 -0500
Subject: Re: Intel vs AMD x86-64
From: Terje Eggestad <terje.eggestad@scali.com>
To: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0402171739020.2686@home.osdl.org>
References: <Pine.LNX.4.58.0402171739020.2686@home.osdl.org>
Content-Type: text/plain
Organization: Scali AS
Message-Id: <1077182108.3492.58.camel@pc-16.office.scali.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 19 Feb 2004 10:15:09 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To whom ever making a list

The sysenter/syscall thing continues. 

On ia32e sysenter/sysleave is legal in 64 bit, but since ia32e also
implement syscall in 64bit (only, not in legacy, nor compatability) this
shouldn't have any practical implications. 

TJ

On Wed, 2004-02-18 at 02:44, Linus Torvalds wrote: 
> Ok, 
>  now that Intel has finally come clean about their x86-64 implementation
> (see
> 
> 	http://www.intel.com/technology/64bitextensions/index.htm?iid=techtrends+spotlight_64bit
> 
> for full details), can somebody write up a list of differences? I know
> there are people who have had access to the Intel docs for a while now,
> and obviously Intel is too frigging proud to list the differences
> explicitly.
> 
> >From what I can tell from a quick look, it looks like it is basically just
> the 3DNow vs SSE3 thing, but I assume there are other details too.  Can
> people who have been involved with this make a quick list for the rest of
> us who only got to see the final details today?
> 
> (And I assume there's somebody with a few patches pending..)
> 
> 	Thanks,
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 

Terje Eggestad
Senior Software Engineer
dir. +47 22 62 89 61
mob. +47 975 31 57
fax. +47 22 62 89 51
terje.eggestad@scali.com

Scali - www.scali.com
High Performance Clustering

