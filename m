Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316574AbSGQSIZ>; Wed, 17 Jul 2002 14:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316569AbSGQSIY>; Wed, 17 Jul 2002 14:08:24 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:15346 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316530AbSGQSIY>; Wed, 17 Jul 2002 14:08:24 -0400
Subject: Re: [patch 1/13] minimal rmap
From: Robert Love <rml@tech9.net>
To: Daniel Phillips <phillips@arcor.de>
Cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <E17Ut3V-0004OY-00@starship>
References: <3D3500AA.131CE2EB@zip.com.au>  <E17Ut3V-0004OY-00@starship>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 17 Jul 2002 11:11:16 -0700
Message-Id: <1026929477.1085.19.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-17 at 10:57, Daniel Phillips wrote:
> On Wednesday 17 July 2002 07:29, Andrew Morton wrote:
> > 11: The nightly updatedb run is still evicting everything.
> 
> That is not a problem with rmap per se, it's a result of not properly 
> handling streaming IO.  I don't think you want to get bogged down in this 
> detail at the moment, it will only distract from the real issues.  My 
> recommendation is to just pretend for the time being that this is correct 
> behaviour.

A good argument for an O_STREAM... various semantics we can modify for
it.

	Robert Love

