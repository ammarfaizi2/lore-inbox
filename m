Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313038AbSE1INL>; Tue, 28 May 2002 04:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313060AbSE1INK>; Tue, 28 May 2002 04:13:10 -0400
Received: from hicks.adgrafix.com ([64.55.193.2]:47794 "EHLO
	hicks.adgrafix.com") by vger.kernel.org with ESMTP
	id <S313038AbSE1INK>; Tue, 28 May 2002 04:13:10 -0400
Message-ID: <3CF33C10.1090302@tungstengraphics.com>
Date: Tue, 28 May 2002 09:13:04 +0100
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.18: DRM + cmpxchg issues
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam,

I expect the answer is that we need to dig out the old one.

Previously I don't think the full cmpxchg semantics werere required unless the 
box is smp -- there's no case where atomic operations are required for 
hardware interaction, for example.  ...

Probably this changed with preempt, though, so we need one even on UP boxes...

Keith

