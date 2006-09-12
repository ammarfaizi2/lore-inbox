Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWILFed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWILFed (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 01:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWILFed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 01:34:33 -0400
Received: from 1wt.eu ([62.212.114.60]:34322 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1750707AbWILFec (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 01:34:32 -0400
Date: Tue, 12 Sep 2006 07:27:29 +0200
From: Willy Tarreau <w@1wt.eu>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Jon Lewis <jlewis@lewis.org>, Perego Paolo Franco <p.perego@reply.it>,
       linux-kernel@vger.kernel.org, Hadmut Danisch <hadmut@danisch.de>,
       torvalds@osdl.org
Subject: Re: Linux kernel source archive vulnerable
Message-ID: <20060912052729.GF541@1wt.eu>
References: <20060907182304.GA10686@danisch.de> <D432C2F98B6D1B4BAE47F2770FEFD6B612B8B7@to1mbxs02.replynet.prv> <Pine.LNX.4.61.0609111334460.2498@soloth.lewis.org> <8E63F0FB-DDD3-41D4-AFA7-88E66D0E9C8D@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8E63F0FB-DDD3-41D4-AFA7-88E66D0E9C8D@mac.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 01:06:37AM -0400, Kyle Moffett wrote:
> On Sep 11, 2006, at 14:29:58, Jon Lewis wrote:
> >On Fri, 8 Sep 2006, Perego Paolo Franco wrote:
> >
> >>Anyway just few considerations:
> >>2) a good sysadmin is aware that /usr/src is NOT supposed to be  
> >>world writable
> >
> >For some reason (bug in how they're being checked out of git, I  
> >assume), the latest kernel source tar files have all files and  
> >directories world writable.  This is not how it's been in the past  
> >and is not how it should be.
> 
> -ENOBUG
> 
> Please see these threads and quit bringing up this topic like crazy:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=113304241100330&w=2
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114635639325551&w=2

BTW, since git 1.4.2, it's possible to specify "umask=022" in the [tar]
section of the repo config to bring back the old behaviour. Maybe it
would be a good idea to use it on Linus' side to make everyone happy ?

Regards,
Willy

