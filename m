Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbVIZGjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbVIZGjh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 02:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbVIZGjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 02:39:37 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:20873 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932411AbVIZGjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 02:39:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Subject:From:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=SpWtq1fjkbgb2L0Zr1Ef/fe/icsjptuYgeop14pAiKsU00yx6RTAY2TIxgw6HfVZLW4+R2nDNXoFhIYABoZK5xlUs6iAVVMNphBOX7FHPlznXnycvefE6uceQrsOPavonUe7lvx4hphCToY4UfkyMn1GlcYLNwTWkw3oEdU+rWo=  ;
Subject: Re: [PATCH] RT: Checks for cmpxchg in get_task_struct_rcu()
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: dwalker@mvista.com, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050926062631.GE3273@elte.hu>
References: <1127345874.19506.43.camel@dhcp153.mvista.com>
	 <433201FC.8040004@yahoo.com.au>  <20050926062631.GE3273@elte.hu>
Content-Type: text/plain
Date: Mon, 26 Sep 2005 16:39:13 +1000
Message-Id: <1127716753.5101.25.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-26 at 08:26 +0200, Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> > You need my atomic_cmpxchg patches that provide an atomic_cmpxchg (and 
> > atomic_inc_not_zero) for all architectures.
> 
> yeah. When will they be merged upstream?
> 

Well they're in -mm now, you can put them in your RT tree until they're
in mainline... I guess realistically, 2.6.15. They should blow up fairly
quickly if there are any problems with them, but they simply need a bit
of testing on all architectures which I cannot do and I suspect even -mm
isn't tested on at least half of them.


-- 
SUSE Labs, Novell Inc.



Send instant messages to your online friends http://au.messenger.yahoo.com 
