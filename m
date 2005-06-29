Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262338AbVF2Rz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262338AbVF2Rz4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 13:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262346AbVF2Rzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 13:55:45 -0400
Received: from dsl.dynamic851009584.ttnet.net.tr ([85.100.95.84]:7110 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262338AbVF2RyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 13:54:23 -0400
From: Ismail Donmez <ismail@kde.org.tr>
Organization: Bogazici University
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.6.13-rc1 problems
Date: Wed, 29 Jun 2005 20:55:01 +0300
User-Agent: KMail/1.8.50
Cc: randy_dunlap <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
References: <200506291934.32909.ismail@kde.org.tr> <200506292015.11494.ismail@kde.org.tr> <Pine.LNX.4.61.0506291842360.4262@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0506291842360.4262@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506292055.02153.ismail@kde.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 June 2005 20:51, Hugh Dickins wrote:
> On Wed, 29 Jun 2005, Ismail Donmez wrote:
> >=20
> > Thank you both!.=C2=A0Any idea about this part? :
> >=20
> > Jun 29 19:16:32 localhost kernel: Badness in __kfree_skb at=20
> > net/core/skbuff.c:290
>
> I've not seen that one.  It's _possible_ that it's caused by the
> same get_request bug: although that's over in a different subsystem,
> it does mess up the preempt_count/hardirq_count enough to be able to
> cause such a problem elsewhere.  But I see this message came 87 secs
> after your others, which makes that unlikely.  Do you still see this
> __kfree_skb badness after running with the get_request fix?

So far its fine. Thank you.

ismail

-- 
Animals use pee to mark their territories. Humans use others' girl friends
