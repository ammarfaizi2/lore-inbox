Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbWC1Vr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWC1Vr0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 16:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWC1Vr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 16:47:26 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:51168
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932237AbWC1VrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 16:47:25 -0500
From: Rob Landley <rob@landley.net>
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [OT] Non-GCC compilers used for linux userspace
Date: Tue, 28 Mar 2006 16:47:05 -0500
User-Agent: KMail/1.8.3
Cc: Eric Piel <Eric.Piel@tremplin-utc.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, nix@esperi.org.uk,
       mmazur@kernel.pl, linux-kernel@vger.kernel.org,
       llh-discuss@lists.pld-linux.org
References: <200603141619.36609.mmazur@kernel.pl> <442960B6.2040502@tremplin-utc.net> <7E2F0C3C-4091-4EEB-8E10-C1F58F94BD59@mac.com>
In-Reply-To: <7E2F0C3C-4091-4EEB-8E10-C1F58F94BD59@mac.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200603281647.06020.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 March 2006 11:20 am, Kyle Moffett wrote:
> On Mar 28, 2006, at 11:13:42, Eric Piel wrote:
> > 03/28/2006 05:57 PM, Kyle Moffett wrote/a écrit:
> >> But my question still stands.  Does anybody actually use any non-
> >> GCC compiler for userspace in Linux?
> >
> > At least in the domain of HPC, I've seen people which were
> > compiling mostly *everything* with the intel compiler (x86 and
> > ia64) for performance reason. So... yes userspace is sometimes
> > compiled with non-GCC compiler :-)
>
> Ok, well, the Intel compiler actually ends up emulating GCC and
> supports most of its extensions; supposedly it can even be used to
> compile the kernel sources, as per include/linux/compiler-intel.h. (I
> don't know how recently this has been tested, though)  So does
> anybody compile userspace under anything other than GCC or Intel
> compilers?  Do any such compilers even exist?
>
> Cheers,
> Kyle Moffett

I play with Fabrice Bellard's Tiny C Compiler (http://www.tinycc.org), and 
hope to get a distro compiled with it someday, at least as a proof of 
concept.

That aims for full c99 and is already implementing a lot of gcc stuff too.

Rob
-- 
Never bet against the cheap plastic solution.
