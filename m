Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277966AbRJRSsB>; Thu, 18 Oct 2001 14:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277968AbRJRSrl>; Thu, 18 Oct 2001 14:47:41 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:1546 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S277966AbRJRSrf>;
	Thu, 18 Oct 2001 14:47:35 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200110181847.WAA04552@ms2.inr.ac.ru>
Subject: Re: Ref: zerocopy +netfilter performance problem.
To: ravi_chamarti@yahoo.com (Ravi Chamarti)
Date: Thu, 18 Oct 2001 22:47:46 +0400 (MSK DST)
Cc: ravi_chamarti@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <20011018184124.57237.qmail@web20901.mail.yahoo.com> from "Ravi Chamarti" at Oct 18, 1 11:41:24 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> How many netfilter modules exist which do not

All of them.

> if the somehow hook register shows interest only in
> header

All the headers except for IP header can be split, at least
defragmenter generates them.

So, not this but rather: "does it understand that skb may be not linear?"

It will work of course.

Alexey
