Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281924AbRKUQwA>; Wed, 21 Nov 2001 11:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281904AbRKUQvl>; Wed, 21 Nov 2001 11:51:41 -0500
Received: from ns01.netrox.net ([64.118.231.130]:20430 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S281917AbRKUQvg>;
	Wed, 21 Nov 2001 11:51:36 -0500
Subject: Re: [PATCH] Documentation/Changes
From: Robert Love <rml@tech9.net>
To: Dmitri Popov <popov@krista.ru>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.31.0111211210040.5542-100000@popov.krista.ru>
In-Reply-To: <Pine.LNX.4.31.0111211210040.5542-100000@popov.krista.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 21 Nov 2001 11:50:12 -0500
Message-Id: <1006361415.1307.3.camel@icbm>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-11-21 at 04:32, Dmitri Popov wrote: 
> I'd like to note that there is nothing abount quota tools in
> Documentation/Changes. I tried to use one of Alan Cox kernels some weeks
> ago, and was very surprised, when quota utilities 2.00 stopped working.
> And I didn't find any information about correct quota tools in all the
> source tree! At last I searched for the latest quota-tools in the Internet
> (ftp://atrey.karlin.mff.cuni.cz/pub/local/jack/quota/utils/)
> and installed it. Now it works. As I can understand, the current 2.4.*
> will also need new utilities.

I believe Alan's tree had 32-bit quota support, which requires a
different version of quota-tools. If you return to Linus's tree, your
original version will work. 

For what its worth, Linus has finally merged much of Alan's tree into
his own, and is pretty much done as of 2.4.15-pre.  32-bit quotas were
_not_ merged. 

	Robert Love

