Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310272AbSCGKU4>; Thu, 7 Mar 2002 05:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310274AbSCGKUr>; Thu, 7 Mar 2002 05:20:47 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:45062 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S310272AbSCGKUK>;
	Thu, 7 Mar 2002 05:20:10 -0500
Date: Wed, 6 Mar 2002 23:21:50 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Woodhouse <dwmw2@infradead.org>, Jeff Dike <jdike@karaya.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Benjamin LaHaise <bcrl@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages
Message-ID: <20020306222149.GC370@elf.ucw.cz>
In-Reply-To: <505.1015411792@redhat.com> <E16iecJ-0007Nn-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16iecJ-0007Nn-00@the-village.bc.nu>
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > You say 'at once'. Does UML somehow give pages back to the host when they're 
> > freed, so the pages that are no longer used by UML can be discarded by the 
> > host instead of getting swapped?
> 
> Doesn't seem to but it looks like madvise might be enough to make that
> happen. That BTW is an issue for more than UML - it has a bearing on
> running lots of Linux instances on any supervisor/virtualising system
> like S/390

I just imagined hardware which supports freeing memory -- just do not
refresh it any more to conserve power ;-))).

Granted, it would probably only make sense in big chunks, like 2MB or
so... It might make sense for a PDA...
									Pavel

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
