Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267273AbSLEACE>; Wed, 4 Dec 2002 19:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267276AbSLEACD>; Wed, 4 Dec 2002 19:02:03 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:16653 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S267273AbSLEACB>; Wed, 4 Dec 2002 19:02:01 -0500
Date: Thu, 5 Dec 2002 11:09:21 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Greg KH <greg@kroah.com>
cc: linux-security-module@wirex.com, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] LSM fix for stupid "empty" functions - take 2
In-Reply-To: <20021204001322.GA23464@kroah.com>
Message-ID: <Mutt.LNX.4.44.0212051105290.5495-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Dec 2002, Greg KH wrote:

> Hi all,
> 
> Here's an updated version of the previous patch I sent out.  It
> incorporates all of the different changes people made.
> 
> If there aren't any objections, I'll be sending this out to Linus soon.

Looks good, with Chris' additions.  The hook verification issue I raised 
earlier is a non-issue: it might be useful, but can be addressed in other 
ways by module authors if needed without uglifying the mainline code.

Thanks for doing this work Greg.


- James
-- 
James Morris
<jmorris@intercode.com.au>


