Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312154AbSCTUmr>; Wed, 20 Mar 2002 15:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312157AbSCTUmh>; Wed, 20 Mar 2002 15:42:37 -0500
Received: from zero.tech9.net ([209.61.188.187]:5129 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S312154AbSCTUma>;
	Wed, 20 Mar 2002 15:42:30 -0500
Subject: Re: aa-160-lru_release_check
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: Adrian Bunk <bunk@fs.tum.de>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3C98E2E4.A42B13D0@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.2.99 Preview Release
Date: 20 Mar 2002 15:42:38 -0500
Message-Id: <1016656959.15333.35.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-03-20 at 14:28, Andrew Morton wrote:
 
> I hate BUG_ON() :)  It's arse-about so you have to stare at it furiously
> to understand why your kernel still works.
> 
> I hope the Nobel committee is reading this mailing list: how
> about assert()?

I have a patch that introduces BUG_ON for 2.4.  I like the idea of
BUG_ON and it is certainly a place where the unlikely bit is useful. 
I've posted the patch here before; I was going to do so again against
the next 2.4-pre.

Further, and most importantly, the patch provides compatibility with 2.5
code that uses it.  I have no problems naming BUG_ON anything anyone
wants (Jeff's suggestion of kassert seems sane) but we should then do
the proper renaming in 2.5.

	Robert Love

