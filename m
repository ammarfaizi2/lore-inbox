Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268929AbRHPXHh>; Thu, 16 Aug 2001 19:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268971AbRHPXH1>; Thu, 16 Aug 2001 19:07:27 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:33544 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S268929AbRHPXHM>; Thu, 16 Aug 2001 19:07:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "David S. Miller" <davem@redhat.com>, tpepper@vato.org
Subject: Re: 2.4.9 does not compile [PATCH]
Date: Fri, 17 Aug 2001 01:13:38 +0200
X-Mailer: KMail [version 1.3]
Cc: f5ibh@db0bm.ampr.org, linux-kernel@vger.kernel.org
In-Reply-To: <200108162111.XAA07177@db0bm.ampr.org> <20010816144109.A5094@cb.vato.org> <20010816.153151.74749641.davem@redhat.com>
In-Reply-To: <20010816.153151.74749641.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010816230719Z16545-1231+1256@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 17, 2001 12:31 am, David S. Miller wrote:
>    From: tpepper@vato.org
>    Date: Thu, 16 Aug 2001 14:41:09 -0700
> 
>    Confirmed here.  Looks like a pretty obvious goof to me.  Does the 
following
>    fix it for you?
> 
> The args and semantics of min/max changed to take
> a type first argument,

They did?  This three argument min is butt-ugly, not to mention a completely 
original way of expressing the idea that is very much in conflict with every 
other expression of min I have ever seen.

What is wrong with using typeof?  If you must have a three argument min, 
could it please be called "type_min" of similar.

> the problem with this ntfs file is that it fails to include linux/kernel.h

--
Daniel
