Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318755AbSHBJEz>; Fri, 2 Aug 2002 05:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318757AbSHBJEz>; Fri, 2 Aug 2002 05:04:55 -0400
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:54161 "EHLO
	completely") by vger.kernel.org with ESMTP id <S318755AbSHBJEz>;
	Fri, 2 Aug 2002 05:04:55 -0400
From: Ryan Cumming <ryan@completely.kicks-ass.org>
To: "David S. Miller" <davem@redhat.com>, davidm@hpl.hp.com,
       davidm@napali.hpl.hp.com
Subject: Re: large page patch
Date: Fri, 2 Aug 2002 02:05:43 -0700
User-Agent: KMail/1.4.5
Cc: gh@us.ibm.com, riel@conectiva.com.br, akpm@zip.com.au,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, rohit.seth@intel.com,
       sunil.saxena@intel.com, asit.k.mallick@intel.com
References: <15690.6005.624237.902152@napali.hpl.hp.com> <15690.9727.831144.67179@napali.hpl.hp.com> <20020802.012040.105531210.davem@redhat.com>
In-Reply-To: <20020802.012040.105531210.davem@redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200208020205.47308.ryan@completely.kicks-ass.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 2, 2002 01:20, David S. Miller wrote:
>    From: David Mosberger <davidm@napali.hpl.hp.com>
>    Date: Thu, 1 Aug 2002 23:26:07 -0700
>
>    I'm a bit concerned about this, too.  My preference would have been to
>    use the regular mmap() and shmat() syscalls with some
>    augmentation/hint as to what the preferred page size is (Simon
>    Winwood's OLS 2002 paper talks about some options here).  I like this
>    because hints could be useful even with a transparent superpage
>    scheme.
>
> A "hint" to use superpages?  That's absurd.

What about applications that want fine-grained page aging? 4MB is a tad on the 
course side for most desktop applications.

-Ryan
