Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268032AbUHQAMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268032AbUHQAMz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 20:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268036AbUHQAMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 20:12:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37811 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268032AbUHQAIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 20:08:46 -0400
Date: Mon, 16 Aug 2004 17:08:33 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Mike_Phillips@URSCorp.com
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Neil Horman <nhorman@redhat.com>
Subject: Re: [Patch} to fix oops in olympic token ring driver on media
 disconnect
Message-Id: <20040816170833.7f2b0e46@lembas.zaitcev.lan>
In-Reply-To: <OF11E315D2.D4CBAED1-ON85256EF2.0052F29D-85256EF2.0053587E@urscorp.com>
References: <411D536A.7050206@pobox.com>
	<OF11E315D2.D4CBAED1-ON85256EF2.0052F29D-85256EF2.0053587E@urscorp.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2004 11:10:19 -0400
Mike_Phillips@URSCorp.com wrote:

> > Well, regardless, Neil's patch is IMO a good first step.
> 
> Neil's patch is to make the annoying regression test failure go away. To 
> be honest I have had *one* user email me that this is a problem and once I 
> gave them the "don't remove the cable on token ring, its not ethernet" 
> talk, they were fine. 

Maybe they are afraid of your bofh-ness, man.

> It works, its used by an ever decreasing number of users - let it have a 
> peaceful and graceful old age.

I don't think this works with a bug so clear-cut as this one.

On the USB front it's so hard to find any users with meaningful
bug reports that I apply fixes for singular users, if they make
broader sense. How do you know that that one user you mentioned is
not a representative of countless IBM minions who clang their chains,
pull Token Ring cables and cry in their dungeons...

-- Pete
