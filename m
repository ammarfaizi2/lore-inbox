Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269027AbTBXAcr>; Sun, 23 Feb 2003 19:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269029AbTBXAcr>; Sun, 23 Feb 2003 19:32:47 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:22248 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S269027AbTBXAcq>;
	Sun, 23 Feb 2003 19:32:46 -0500
Date: Sun, 23 Feb 2003 17:36:04 -0700
From: yodaiken@fsmlabs.com
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030223173604.A30865@hq.fsmlabs.com>
References: <E18moa2-0005cP-00@w-gerrit2> <Pine.LNX.4.44.0302222354310.8609-100000@dlang.diginsite.com> <20030223082036.GI10411@holomorphy.com> <b3b6oa$bsj$1@penguin.transmeta.com> <1046031687.2140.32.camel@bip.localdomain.fake>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1046031687.2140.32.camel@bip.localdomain.fake>; from xavier.bestel@free.fr on Sun, Feb 23, 2003 at 09:21:27PM +0100
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2003 at 09:21:27PM +0100, Xavier Bestel wrote:
> Le dim 23/02/2003 à 20:17, Linus Torvalds a écrit :
> 
> > And the baroque instruction encoding on the x86 is actually a _good_
> > thing: it's a rather dense encoding, which means that you win on icache. 
> > It's a bit hard to decode, but who cares? Existing chips do well at
> > decoding, and thanks to the icache win they tend to perform better - and
> > they load faster too (which is important - you can make your CPU have
> > big caches, but _nothing_ saves you from the cold-cache costs). 
> 
> Next step: hardware gzip ?

See ARM "thumb"
