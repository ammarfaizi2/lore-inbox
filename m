Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbUK2Xny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbUK2Xny (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 18:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbUK2Xny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 18:43:54 -0500
Received: from mercury.sdinet.de ([193.103.161.30]:62135 "EHLO
	mercury.sdinet.de") by vger.kernel.org with ESMTP id S261855AbUK2Xnu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 18:43:50 -0500
Date: Tue, 30 Nov 2004 00:43:49 +0100 (CET)
From: Sven-Haegar Koch <haegar@sdinet.de>
To: Bernard Normier <bernard@zeroc.com>
Cc: jonathan@jonmasters.org, linux-kernel@vger.kernel.org
Subject: Re: Concurrent access to /dev/urandom
In-Reply-To: <002c01c4d669$28ec6e30$6401a8c0@centrino>
Message-ID: <Pine.LNX.4.61.0411300041290.816@mercury.sdinet.de>
References: <006001c4d4c2$14470880$6400a8c0@centrino>
 <35fb2e5904112914476df48518@mail.gmail.com> <002c01c4d669$28ec6e30$6401a8c0@centrino>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2004, Bernard Normier wrote:

>>> I use /dev/urandom to generate UUIDs by reading 16 random bytes from
>>> /dev/urandom (very much like e2fsprogs' libuuid).
>> 
>> Why not use /dev/random for such data instead?
>
> A UUID generator that blocks from time to time waiting for entropy would not 
> be usable.

Especially when used on a box without any effective entropy source - like 
praktically most cheap servers stashed away into some rack.

c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)
