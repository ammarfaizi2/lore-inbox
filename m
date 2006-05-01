Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbWEAVBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWEAVBy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 17:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbWEAVBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 17:01:54 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:19174 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932258AbWEAVBx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 17:01:53 -0400
Date: Mon, 1 May 2006 23:01:45 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jiri Slaby <jirislaby@gmail.com>
cc: David Woodhouse <dwmw2@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] CodingStyle: add typedefs chapter
In-Reply-To: <4456732B.2090009@gmail.com>
Message-ID: <Pine.LNX.4.61.0605012300080.782@yvahk01.tjqt.qr>
References: <20060430174426.a21b4614.rdunlap@xenotime.net> 
 <Pine.LNX.4.61.0605011559010.31804@yvahk01.tjqt.qr>
 <1146502730.2885.128.camel@hades.cambridge.redhat.com>
 <Pine.LNX.4.61.0605012219560.32033@yvahk01.tjqt.qr> <4456732B.2090009@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> What about task_t vs struct task_struct? Both are used in the kernel. 
>>> task_t should probably die.
>> 
>> Acked.
>Wouldn't this be a janitors' task?

Too simple :)

  find rc3 -type f -print0 | xargs -0 perl -i -pe
    's/\btask_t\b/struct task_struct'

+ a compile test afterwards. Something I missed? (Besides that lines may 
get longer and violate the 80-column CodingStyle rule.)


Jan Engelhardt
-- 
