Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbTC0Sy2>; Thu, 27 Mar 2003 13:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261294AbTC0Sy2>; Thu, 27 Mar 2003 13:54:28 -0500
Received: from [81.2.110.254] ([81.2.110.254]:3575 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id <S261292AbTC0Sy1>;
	Thu, 27 Mar 2003 13:54:27 -0500
Subject: Re: wonderffffffffull ac filemap patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0303271750220.2542-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0303271750220.2542-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048792021.3228.26.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 27 Mar 2003 19:07:03 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-27 at 17:59, Hugh Dickins wrote:
> > For 2.4 I just wanted to handle what we had and fix up the spec violations.
> > For 2.5.x rlimit64 is calling 8)
> 
> Fixing up a silly in what's there, that I understand; and adding rlimit64,
> that too.  But on 64-bit arches, isn't rlimit already rlimit64?
> 
> If the answer to that is Yes, then doesn't the 0xFFFFFFFFULL test cripple
> them?  If the answer to that is No, then how come we're trying to handle
> a case in which limit has more than 32 bits?

Infallibility is only available by special request. I'd have to read the
code and specs again but what you say sounds quite reasonable since off_t
would be 64bit, and rlimit types likewise

