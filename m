Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbUCWFkh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 00:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbUCWFkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 00:40:37 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:26465 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262014AbUCWFke
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 00:40:34 -0500
Date: Tue, 23 Mar 2004 06:41:24 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: cliff white <cliffw@osdl.org>
Cc: sam@ravnborg.org, rddunlap@osdl.org, linux-kernel@vger.kernel.org,
       maryedie@osdl.org, cherry@osdl.org
Subject: Re: Fw: Re: parallel make problems (-mm) -now found in 2.6.5-rc1 also
Message-ID: <20040323054124.GA2246@mars.ravnborg.org>
Mail-Followup-To: cliff white <cliffw@osdl.org>, sam@ravnborg.org,
	rddunlap@osdl.org, linux-kernel@vger.kernel.org, maryedie@osdl.org,
	cherry@osdl.org
References: <20040312120024.2cef94c8.rddunlap@osdl.org> <20040322131629.52598c2f.cliffw@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040322131629.52598c2f.cliffw@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2004 at 01:16:29PM -0800, cliff white wrote:
> 
> Hi Sam, 
> randy dunlap is on vacation this week, 
> (and i was last week ) so i am trying to get a resolution to
> the parallel make problem.
> 
> Tested your patch below and it didn't help us. The patch doesn't
> apply clean past 2.6.4-mm1.
> 
> We now see this exact failure against 2.6.5-rc1 for our 8-way machines,
> so we have much concern. 
> 
> Is there another fix around we could try?

I've updated the patch since, and it is now in Linus latest - thanks to Andrew.
A good sign you do not have the latest version is the fact that you still
refer to fixdep in scripts/ (my bad in the frst version).
Could you either try with Linus latest, or at least take a verbatim copy
of the Makefile from there.

I have reports of succes with make -j10 from others.

If it still fails please mail me the output without and with V=1,
then I will dig into it.

	Sam
