Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268965AbUIQPmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268965AbUIQPmT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 11:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268881AbUIQPjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 11:39:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:36013 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268965AbUIQPgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 11:36:14 -0400
Date: Fri, 17 Sep 2004 08:35:57 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: Michael Hunold <hunold@linuxtv.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6][4/14] dvb core update
In-Reply-To: <Pine.LNX.4.61.0409171648270.8300@jjulnx.backbone.dif.dk>
Message-ID: <Pine.LNX.4.58.0409170831480.2338@ppc970.osdl.org>
References: <414AF2CA.3000502@linuxtv.org> <414AF31B.1090103@linuxtv.org>
 <414AF399.3030708@linuxtv.org> <414AF41A.6060009@linuxtv.org>
 <414AF461.4050707@linuxtv.org> <Pine.LNX.4.61.0409171648270.8300@jjulnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 17 Sep 2004, Jesper Juhl wrote:
> 
> Besides, didn't C99 make C++ style comments valid for C code as well?  
> Does CodingStyle have any oppinion on this?

We've allowed C++ comments for a longish time as far as I can tell. They 
are very common, all over the tree according to a quick grep. Admittedly 
they are more common in certain driver setups than in "general code", but 
I don't think there is really any reason (other than maintainer 
preferences) to convert one into the other.

		Linus
