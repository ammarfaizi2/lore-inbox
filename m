Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316897AbSHJNUy>; Sat, 10 Aug 2002 09:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316898AbSHJNUy>; Sat, 10 Aug 2002 09:20:54 -0400
Received: from [195.63.194.11] ([195.63.194.11]:14858 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316897AbSHJNUy>; Sat, 10 Aug 2002 09:20:54 -0400
Message-ID: <3D5512C1.1080607@evision.ag>
Date: Sat, 10 Aug 2002 15:18:57 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.1) Gecko/20020724
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cantab.net>
CC: "David S. Miller" <davem@redhat.com>, akpm@zip.com.au,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/12] misc fixes
References: <3D54647C.DB6DE08A@zip.com.au> <3D54647C.DB6DE08A@zip.com.au> <5.1.0.14.2.20020810125310.00ae3690@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
>
> If no one beats me to it I will submit a patch to change PAGE_SIZE (and 
> thus automatically PAGE_CACHE_SIZE) on all architectures to no longer 
> use the "UL" type qualifier which is responsible for the breakage. This 
> supersedes my previous ugly patch introducing a PAGE_{CACHE_,}MASK_LL...


Just for the record - If you actually try to compile the kernel with a
C++ compiler it will warn you nicely about the particular issue here.

