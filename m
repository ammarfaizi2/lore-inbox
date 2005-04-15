Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbVDOIUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbVDOIUd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 04:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbVDOIUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 04:20:33 -0400
Received: from mail.dif.dk ([193.138.115.101]:51114 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261766AbVDOIU1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 04:20:27 -0400
Date: Fri, 15 Apr 2005 10:23:15 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/fcntl.c : don't test unsigned value for less than
 zero
In-Reply-To: <20050415013100.GY8669@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.62.0504151021360.2475@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0504150303480.3466@dragon.hyggekrogen.localhost>
 <20050415013100.GY8669@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2005, Matthew Wilcox wrote:

> On Fri, Apr 15, 2005 at 03:07:42AM +0200, Jesper Juhl wrote:
> > 'arg' is unsigned so it can never be less than zero, so testing for that 
> > is pointless and also generates a warning when building with gcc -W. This 
> > patch eliminates the pointless check.
> 
> Didn't Linus already reject this one 6 months ago?
> 
Hmmm, perhaps you are right. There was some discussion about similar 
patches a while back. That had slipped my mind.  

-- 
Jesper 

