Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263961AbTIFH7F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 03:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbTIFH7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 03:59:05 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:32759 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S263961AbTIFH7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 03:59:02 -0400
Subject: Re: [PATCH] Nick's scheduler policy v12
From: Martin Schlemmer <azarah@gentoo.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Nick Piggin <piggin@cyberone.com.au>, Mike Fedyk <mfedyk@matchmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <6470000.1062819391@[10.10.2.4]>
References: <3F58CE6D.2040000@cyberone.com.au> <195560000.1062788044@flay>
	 <20030905202232.GD19041@matchmail.com> <207340000.1062793164@flay>
	 <3F5935EB.4000005@cyberone.com.au>  <6470000.1062819391@[10.10.2.4]>
Content-Type: text/plain
Message-Id: <1062834559.3372.35.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 06 Sep 2003 09:49:19 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-09-06 at 05:36, Martin J. Bligh wrote:

> > Well it would be nice if someone could find out how to do it, but I
> > think that if we want X to be able to get 80% CPU when 2 other CPU hogs
> > are running, you have to renice it.
> 
> OK. So you renice it ... then your two cpu jobs exit, and you kick off
> xmms. Every time you waggle a window, X will steal the cpu back from
> xmms, and it'll stall, surely? That's what seemed to happen before.
> I don't see how you can fix anything by doing static priority alterations
> (eg nice), because the workload changes.
> 

Not here with version 10 of Nick's patch, and X reniced to -10.
I have not had chance to test v12, but will do tonight when I
get home.


Cheers,

-- 
Martin Schlemmer


