Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261761AbSI2UVG>; Sun, 29 Sep 2002 16:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261773AbSI2UUK>; Sun, 29 Sep 2002 16:20:10 -0400
Received: from bitchcake.off.net ([216.138.242.5]:55975 "EHLO mail.off.net")
	by vger.kernel.org with ESMTP id <S261763AbSI2URI>;
	Sun, 29 Sep 2002 16:17:08 -0400
Date: Sun, 29 Sep 2002 16:22:32 -0400
From: Zach Brown <zab@zabbo.net>
To: Dave Jones <davej@codemonkey.org.uk>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.39 list_head debugging
Message-ID: <20020929162232.D13755@bitchcake.off.net>
References: <20020929015852.K13817@bitchcake.off.net> <20020929172247.GA23543@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020929172247.GA23543@suse.de>; from davej@codemonkey.org.uk on Sun, Sep 29, 2002 at 06:22:47PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Two points (both related to return type).
> 1, why is it needed ? none of the macros seems to check it.
> 2, will this work for the #define __list_valid(args...) case ?

its to appease its use with the , operator  in the for(;;).. I vaguely
rememebered there being some rule that the types of all the expressions
have to be the same.. though it certainly works without the return.  are
there any language ninjas around who can call me insane?

I can certainly remove it if it makes people sad.

- z
