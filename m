Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261957AbVFIPl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbVFIPl6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 11:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbVFIPl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 11:41:58 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:24028 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261957AbVFIPly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 11:41:54 -0400
Subject: Re: [PATCH] capabilities not inherited
From: Lee Revell <rlrevell@joe-job.com>
To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <d89l9a$d3i$1@abraham.cs.berkeley.edu>
References: <Pine.GSO.4.58.0506081513340.22095@chewbacca.arl.wustl.edu>
	 <1118265642.969.12.camel@localhost.localdomain>
	 <d88ba7$hck$1@abraham.cs.berkeley.edu>
	 <1118313167.970.15.camel@localhost.localdomain>
	 <d89l9a$d3i$1@abraham.cs.berkeley.edu>
Content-Type: text/plain
Date: Thu, 09 Jun 2005 11:31:23 -0400
Message-Id: <1118331084.15527.26.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-09 at 14:55 +0000, David Wagner wrote:
> Alexander Nyberg  wrote:
> >tor 2005-06-09 klockan 02:59 +0000 skrev David Wagner:
> >> [...] the sendmail attack [...]
> >
> >I'll look this up but it sounds very weird and I don't see how this
> >would happen with this change.
> 
> Yup, it was a weird one indeed -- which is part of why I'm concerned.
> Take a look at the attack again, then re-read my message.  Maybe my
> concerns will make more sense once you refresh your memory about the
> setuid capabilities attack?  If not, feel free to ask again, and I'll
> try to elaborate.  Here is a pointer to one description of that attack:
>     http://www.cs.berkeley.edu/~daw/papers/setuid-usenix02.pdf
>     (jump straight to Section 7.1) 

Thanks for the link, I wish I had that during the realtime LSM debate,
when people were actually recommending that jackd use setuid to grant RT
scheduling ability to clients.

Lee

