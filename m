Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133007AbRDUWux>; Sat, 21 Apr 2001 18:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133008AbRDUWun>; Sat, 21 Apr 2001 18:50:43 -0400
Received: from anime.net ([63.172.78.150]:30222 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S133007AbRDUWuh>;
	Sat, 21 Apr 2001 18:50:37 -0400
Date: Sat, 21 Apr 2001 15:50:26 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: Andi Kleen <ak@suse.de>
cc: Peter Makholm <peter@makholm.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Idea: Encryption plugin architecture for file-systems
In-Reply-To: <20010421213751.A13395@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.30.0104211549370.21994-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Apr 2001, Andi Kleen wrote:
> On Sat, Apr 21, 2001 at 09:21:44PM +0200, Peter Makholm wrote:
> > nagytam@rerecognition.com ("Tamas Nagy") writes:
> > > Idea:
> > > extend the current file-system with an optional plug-in system, which allows
> > > for file-system level encryption instead of file-level.
> > That's is one of the things the loop device offers. For better
> > encryption than XOR you need the patches from kerneli.org.
> No, you don't. The standard kernel loop device supports loading of external
> crypto filters just fine; no patching at all required.

But it is a definite performance killer. A direct plugin to filesystems
would be far more efficient.

-Dan

