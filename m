Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315191AbSFDQfx>; Tue, 4 Jun 2002 12:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315192AbSFDQfw>; Tue, 4 Jun 2002 12:35:52 -0400
Received: from rogue.ncsl.nist.gov ([129.6.101.41]:54486 "EHLO
	rogue.ncsl.nist.gov") by vger.kernel.org with ESMTP
	id <S315191AbSFDQft>; Tue, 4 Jun 2002 12:35:49 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [lkml] Patch for broken Dell C600 and I5000
In-Reply-To: <20020604010756.A32059@devserv.devel.redhat.com>
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: 04 Jun 2002 12:35:43 -0400
Message-ID: <9cfit4zovc0.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Pete Zaitcev <zaitcev@redhat.com> writes:

> Greetings.
> 
> Some time ago I had to work around broken BIOS in Dell C600
> and Linus accepted the patch (it was before Marcelo, IIRC). All this
> time BIOS writers continued to search for the bottom in the barrel
> of brokenness and now we have I5000 brain damaged in a similar way.
> Since I5000 is broken even before it sleeps, I made a different
> workaround.
> 
> Attached patch implements the new workaround and removes the old one.
> 
> Please comment. If nobody objects I'll resend it for Marcelo
> and do an equivalent patch for Linus tree.

What is the problem this fixes?  I don't have any problems with my
C600 suspending and resuming (2.4.19pre7-ac4).  Some of the comments
look BIOS-version-specific... why not just upgrade the BIOS?  (The
comment I saw referred to version A06, but I have A17!)

Correct me if I'm missing something here... I didn't read the patch
too carefully...

ian

