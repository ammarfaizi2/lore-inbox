Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755617AbWKVKdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755617AbWKVKdl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 05:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755622AbWKVKdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 05:33:41 -0500
Received: from mail.station1.mxsweep.com ([212.147.136.149]:42757 "EHLO
	blue.mxsweep.com") by vger.kernel.org with ESMTP id S1755617AbWKVKdk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 05:33:40 -0500
Message-ID: <45642744.2080109@draigBrady.com>
Date: Wed, 22 Nov 2006 10:32:36 +0000
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Linus Torvalds <torvalds@osdl.org>, Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Simple script that locks up my box with recent kernels
References: <Pine.LNX.4.64.0610071408220.3952@g5.osdl.org> <9a8748490610081633k7bf011d1q131b2f9e06f2808d@mail.gmail.com> <9a8748490610161545i309c416aja4f39edef8ea04e2@mail.gmail.com> <Pine.LNX.4.64.0610161554140.3962@g5.osdl.org> <9a8748490610161613y7c314e64rfdfafb4046a33a02@mail.gmail.com> <9a8748490610231330y65f3e243pe1101d11a28dbbfa@mail.gmail.com> <9a8748490611211646o2c92564dmfe8d6ffdf66228ba@mail.gmail.com> <Pine.LNX.4.64.0611211827590.3338@woody.osdl.org> <20061122032512.GE533@redhat.com> <Pine.LNX.4.64.0611211944120.3352@woody.osdl.org> <20061122034928.GF533@redhat.com>
In-Reply-To: <20061122034928.GF533@redhat.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Mlf-Version: 5.0.0.8233
X-Mlf-UniqueId: o200611221034570031457
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Tue, Nov 21, 2006 at 07:44:45PM -0800, Linus Torvalds wrote:
> 
>  > > memset(buf, 0, SIZE);
>  > 
>  > I'm just checking that you're paying attention.
>  > 
>  > There's a reason sparse warns about the third parameter of a memset() 
>  > being zero ;)
> 
> Heh, it's amazing how commonplace that mistake is.
> Come back bzero, all is forgiven..

It's interesting to do the following on google codesearch

lang:^(c|c\+\+)$ memset\ *\(.*,\ *0\ *\);
http://tinyurl.com/y47qu4

lang:^(c|c\+\+)$ \sif\([^)]*\);
http://tinyurl.com/y4mdbl

It would be interesting to build
up a suite of these regular expressions.

Pádraig.
