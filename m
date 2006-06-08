Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbWFHKqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWFHKqM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 06:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWFHKqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 06:46:11 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:24041 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964781AbWFHKqK (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 06:46:10 -0400
Date: Thu, 8 Jun 2006 12:45:55 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Vladimir V. Saveliev" <vs@namesys.com>
cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Alexey Polyakov <alexey.polyakov@gmail.com>,
       Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       Reiserfs mail-list <Reiserfs-List@namesys.com>,
       Nate Diller <ndiller@namesys.com>
Subject: Re: [PATCH] updated reiser4 - reduced cpu usage for writes by writing
 more than 4k at a time (has implications for generic write code and eventually
 for the IO layer)
In-Reply-To: <1148481586.6395.25.camel@tribesman.namesys.com>
Message-ID: <Pine.LNX.4.61.0606081245160.28703@yvahk01.tjqt.qr>
References: <44736D3E.8090808@namesys.com>  <b5d90b2a0605231326g5319fea8wb9efef34ee5f7ec6@mail.gmail.com>
  <6bffcb0e0605231333n612da806j9bd910cba65e3692@mail.gmail.com>
 <1148481586.6395.25.camel@tribesman.namesys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > I'm actively using Reiser4 on a production servers (and I know a lot
>> > of people that do that too).
>> > Could you please release the patch against the vanilla tree?
>> > I don't think there's a lot of people that will test -mm version,
>> > especially on production servers - -mm is a little bit too unstable.
>> 
>> Any chance to get this patch against 2.6.17-rc4-mm3?
>
>yes, reiser4 updates for latest stock and mm kernels will be out in one
>or two days
>
There is a version out for 2.6.17-rc4-mm1, but for stock kernel? Has the latter
been canceled?


Jan Engelhardt
-- 
