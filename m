Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263503AbTEIV4F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 17:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263506AbTEIV4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 17:56:04 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32518 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263503AbTEIV4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 17:56:03 -0400
Message-ID: <3EBC26BF.2080709@zytor.com>
Date: Fri, 09 May 2003 15:07:59 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: hammer: MAP_32BIT
References: <3EBB5A44.7070704@redhat.com> <20030509092026.GA11012@averell> <16059.37067.925423.998433@gargle.gargle.HOWL> <20030509113845.GA4586@averell> <b9gr03$42n$1@cesium.transmeta.com> <3EBC0084.4090809@redhat.com> <3EBC15B5.4070604@zytor.com> <3EBC2164.6050605@redhat.com>
In-Reply-To: <3EBC2164.6050605@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> H. Peter Anvin wrote:
> 
> 
>>No, it requires 31-bit addresses, and there was a discussion about how
>>some things need 31-bit and some 32-bit addresses.
> 
> 
> That's completely irrelevant to my point.  Whether MAP_32BIT actually
> has a 31 bit limit or not doesn't matter, it's limited as well in the
> possible mmap blocks it can return.
> 
> The only thing I care about is to have a hint and not a fixed
> requirement for mmap().  All your proposals completely ignored this.
> 

Yes, but this is irrelevant to *MY* point... this discussion spawned a
side discussion, and somehow you're upset that it's not addressing your
concern but a different one... seems a bit ridiculous!

Anyway, I already posted that if we're adding MAP_MAXADDR we could also
add MAP_MAXADDR_ADVISORY or something similar to that.  On the other
hand, how big of a performance issue is it really to call mmap() again
in the failure scenario *only*?

	-hpa


