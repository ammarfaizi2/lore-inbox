Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261518AbSKNAwd>; Wed, 13 Nov 2002 19:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261524AbSKNAwd>; Wed, 13 Nov 2002 19:52:33 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28420 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261518AbSKNAwc>; Wed, 13 Nov 2002 19:52:32 -0500
Date: Wed, 13 Nov 2002 16:59:35 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@infradead.org>
cc: rusty@rustcorp.com.au, <linux-kernel@vger.kernel.org>
Subject: Re: module mess in -CURRENT
In-Reply-To: <20021114000206.A8245@infradead.org>
Message-ID: <Pine.LNX.4.44.0211131655580.6810-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 14 Nov 2002, Christoph Hellwig wrote:
> 
> Linus, please backout that patch until we a) have modutils that support
> both the new and old code and b) support at least such basic features
> as parsing modules.conf and supporting parameters.

Quite frankly, at this time a backout means that the thing doesn't go in 
_at_all_.

It came in before the feature freeze, but I decided that instead of having 
a totally hectic time I woul dmerge stuff that I got before the freeze at 
my own leisure, but backing it out now would be basically saying it's not 
going into 2.6.x. And I think it's worth it.

(There are some other patches I'm still thinking about, notably kprobes
and posix timers, but other than that my plate is fairly empty froma
feature standpoint. And the kexec stuff I want others to test, at least
now it's palatable to me).

People who find the current module situation difficult can just compile in 
the stuff they need for now.

		Linus

