Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVFANCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVFANCx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 09:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVFANCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 09:02:53 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:60885 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S261266AbVFANCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 09:02:38 -0400
From: Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>
Subject: Re: [OT] mailing list management
To: Lukasz Stelmach <stlman@poczta.fm>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Wed, 01 Jun 2005 15:02:23 +0200
References: <4ayEi-52j-23@gated-at.bofh.it> <4ayNT-58e-27@gated-at.bofh.it> <4az7m-5lG-31@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1DdSra-0001cO-UL@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukasz Stelmach <stlman@poczta.fm> wrote:
> Måns Rullgård napisa?(a):

>> Use "reply all", "wide reply", or whatever mozilla thunderbird, which
>> you appear to be using, calls it.

> As I stated somewhere befor this is an option but it also adds the
> author of the original message to the list of recipients thus making one
> receive the same letter twice.

That's intended. Many readers and posters aren't subscribed.
E.g. I read it using news:linux.kernel, since my mail program can't handle
threads well enough. (Besides that, NNTP causes much less traffic for the
same amount of messages:). OTOH, I'd like to get replies to my postings per
mail, since my newsreader is bad for replying to lkml.

Workaround:
--- ~/.procmailrc ---
:0 Wh: msgid.lock
| formail -D 128 .msgid.cache
---
(adjust the 128 as needed)
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
