Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbULTVtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbULTVtw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 16:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbULTVtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 16:49:51 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:31714 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261651AbULTVth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 16:49:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=uDazYfFVS3ZWlnBWci46pWrIS8pJzA2NvSroS2WCZzyEo34RTPp1xmm8FS0FuW7JKvmic3FarS2z+vqIblURmkqX2puMRAY1k+JR7ZT6XzT6Bp41WYFLUrxveKv/SDt7TSQcwe4z3Jsy+5sxf5wWYb60CSOOgv8E3ZsnR4LlKPQ=
Message-ID: <e2e1047f04122013493f5b0151@mail.gmail.com>
Date: Mon, 20 Dec 2004 21:49:35 +0000
From: girish wadhwani <girish.wadh@gmail.com>
Reply-To: girish wadhwani <girish.wadh@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
Cc: Adrian Bunk <bunk@stusta.de>,
       Arne Caspari <arnem@informatik.uni-bremen.de>, bcollins@debian.org,
       linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <1103576759.1252.93.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041220015320.GO21288@stusta.de>
	 <41C694E0.8010609@informatik.uni-bremen.de>
	 <20041220175156.GW21288@stusta.de>
	 <1103576759.1252.93.camel@krustophenia.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please, can't you just hold off on breaking the ieee1394 API at all for
> now?  Currently there are no supported IEEE-1394 audio devices.  This is
> a big deal as most new pro audio interfaces are IEEE-1394 devices.
> There are a few under development, see http://freebob.sf.net.  But they
> don't work yet.  If you rip out half the API you will make it that much
> harder for these developers, by requiring them to be kernel hackers as
> well as driver writers.
> 
> How about waiting until there is _one_ IEEE-1394 audio driver in the
> tree before breaking the API?

I don't think the symbols are an issue for the Freebob project.
Atleast, not right now. The code doesn't use the symbols. Most of the
driver is intended to be in userspace anyways.
Moreover, if you are going to break in the interface, you might as
well do it before the driver
is written rather than after.

Just my 2c.

-Girish   
> Lee
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> mailing list linux1394-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux1394-devel
>
