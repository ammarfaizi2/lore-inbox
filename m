Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315458AbSEGXuL>; Tue, 7 May 2002 19:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315460AbSEGXuK>; Tue, 7 May 2002 19:50:10 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:54739 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315458AbSEGXuH>;
	Tue, 7 May 2002 19:50:07 -0400
Date: Tue, 7 May 2002 16:48:57 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Robert Love <rml@tech9.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, rwhron@earthlink.net, mingo@elte.hu,
        gh@us.ibm.com, linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: O(1) scheduler gives big boost to tbench 192
Message-ID: <20020507164857.G1537@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <20020507151356.A18701@w-mikek.des.beaverton.ibm.com> <E175DhD-0000HF-00@the-village.bc.nu> <20020507154322.F1537@w-mikek2.des.beaverton.ibm.com> <1020814775.2084.43.camel@bigsur>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2002 at 04:39:34PM -0700, Robert Love wrote:
> It is just for pipes we previously used sync, no?

That's the only thing I know of that used it.

I'd really like to know if there are any real workloads that
benefited from this feature, rather than just some benchmark.
I can do some research, but was hoping someone on this list
might remember.  If there is a valid workload, I'll propose
a patch.  However, I don't think we should be adding patches/
features just to help some benchmark that is unrelated to
real world use.

-- 
Mike
