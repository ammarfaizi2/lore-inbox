Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbTFTKt7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 06:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbTFTKt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 06:49:58 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:50119 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262771AbTFTKt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 06:49:58 -0400
Date: Fri, 20 Jun 2003 13:03:57 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Fruhwirth Clemens <clemens-dated-1056970281.42e9@endorphin.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Initial Vector Fix for loop.c.
Message-ID: <20030620110357.GC28711@wohnheim.fh-wedel.de>
References: <20030620090612.GA1322@ghanima.endorphin.org.suse.lists.linux.kernel> <p73u1al3xlw.fsf@oldwotan.suse.de> <20030620101452.GA2233@ghanima.endorphin.org> <20030620102455.GC26678@wotan.suse.de> <20030620103538.GA28711@wohnheim.fh-wedel.de> <20030620105120.GA2450@ghanima.endorphin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030620105120.GA2450@ghanima.endorphin.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 June 2003 12:51:20 +0200, Fruhwirth Clemens wrote:
> 
> Let's see. If there is flag based fix and we make the old behavior default
> we will trick many new users into using the old broken IV metric. If we make
> the new metric default the user can't mount his old images. 

Unless he starts thinking and reads up how it works in 2.6.

> As there is no autodetection for default behavior, there will be no way to
> avoid the pain. Well, almost. We could allocate a new major for a different
> metric, and create  /dev/loop-ng*. That'd be feasible, but actually just a
> pain transfer .. from the user to the developer :)

I don't see a problem with that, assuming there are more users than
developers. :)

Jörn

-- 
Do not stop an army on its way home.
-- Sun Tzu
