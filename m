Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbVIUKrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbVIUKrI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 06:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbVIUKrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 06:47:08 -0400
Received: from moraine.clusterfs.com ([66.96.26.190]:50321 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S1750808AbVIUKrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 06:47:07 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17201.14899.683012.997417@gargle.gargle.HOWL>
Date: Wed, 21 Sep 2005 14:47:15 +0400
To: Hans Reiser <reiser@namesys.com>
Cc: stephen.pollei@gmail.com, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Denis Vlasenko <vda@ilport.com.ua>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
In-Reply-To: <4330A783.9090405@namesys.com>
References: <200509201536.j8KFa6wn011651@laptop11.inf.utfsm.cl>
	<43304A41.7080206@namesys.com>
	<feed8cdd050920150866e7925d@mail.gmail.com>
	<4330A783.9090405@namesys.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser writes:
 > Stephen Pollei wrote:
 > 
 > >
 > >
 > >Also note my opinion, doesn't really count if you grep the kernel
 > >sources for pollei, you won't find anything.
 > >
 > >  
 > >
 > Your opinion counts, but lets see what Nikita says before I say
 > anything.  Nikita is more expert than I in regards to compiler tricks.

That sort of guards was useful early in reiser4 debugging, when a lot of
checks and assertions was  added (specifically, because reiser4 has many
levels of debugging), but I am not sure source code clutter is justified
now.

Nikita.
