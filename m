Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317978AbSHPCRb>; Thu, 15 Aug 2002 22:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318008AbSHPCRb>; Thu, 15 Aug 2002 22:17:31 -0400
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:16258 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S317978AbSHPCRa>; Thu, 15 Aug 2002 22:17:30 -0400
Date: Thu, 15 Aug 2002 19:21:19 -0700
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: [PATCH] rmap 14
Message-ID: <20020816022119.GA1629@gnuppy.monkey.org>
References: <Pine.LNX.4.44L.0208152304420.23404-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0208152304420.23404-100000@imladris.surriel.com>
User-Agent: Mutt/1.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2002 at 11:07:49PM -0300, Rik van Riel wrote:
> This is a fairly minimal change for rmap14 since I've been
> working on 2.5 most of the time. The experimental code in
> this version is a hopefully smarter page_launder() that
> shouldn't do much more IO than needed and hopefully gets
> rid of the stalls that people have seen during heavy swap
> activity.  Please test this version. ;)
> 
> The first release of the 14th version of the reverse
> mapping based VM is now available.
> This is an attempt at making a more robust and flexible VM
> subsystem, while cleaning up a lot of code at the same time.
> The patch is available from:

Hey,

Again, the combination of a kind of felt increase in intelligence in
swap decisions and increase in interactivity made my machine feel
substantally smoother, but it needs to be backed up by other people's
experiences with it.

I wish there was a test for this kind of thing.

bill

