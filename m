Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266900AbUGLRxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266900AbUGLRxX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 13:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265253AbUGLRwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 13:52:51 -0400
Received: from hera.kernel.org ([63.209.29.2]:63697 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S266902AbUGLRv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 13:51:28 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: 0xdeadbeef vs 0xdeadbeefL
Date: Mon, 12 Jul 2004 17:50:53 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ccuj1t$ul9$1@terminus.zytor.com>
References: <1089165901.4373.175.camel@orca.madrabbit.org> <20040707073059.GA20079@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1089654653 31402 127.0.0.1 (12 Jul 2004 17:50:53 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 12 Jul 2004 17:50:53 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20040707073059.GA20079@louise.pinerecords.com>
By author:    Tomas Szepe <szepe@pinerecords.com>
In newsgroup: linux.dev.kernel
>
> On Jul-06 2004, Tue, 19:05 -0700
> Ray Lee <ray-lk@madrabbit.org> wrote:
> 
> > According to K&R, 2nd ed, section A2.5.1 (Integer Constants):
> >
> >         The type of an integer depends on its form, value and suffix.
> >         [...] If it is unsuffixed octal or hexadecimal, it has the first
> >         possible of these types ["in which its value can be represented"
> >         -- from omitted]: int, unsigned int, long int, unsigned long
> >         int.
> 
> Is it safe to assume that C99 compilers append "..., long long int,
> unsigned long long int" to the list?
> 

Yes.

	-hpa
