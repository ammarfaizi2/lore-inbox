Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313305AbSEVN20>; Wed, 22 May 2002 09:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313307AbSEVN2Z>; Wed, 22 May 2002 09:28:25 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39440 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313305AbSEVN2Y>; Wed, 22 May 2002 09:28:24 -0400
Subject: Re: AUDIT: copy_from_user is a deathtrap.
To: pavel@suse.cz (Pavel Machek)
Date: Wed, 22 May 2002 14:47:40 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds), akpm@zip.com.au (Andrew Morton),
        alan@lxorguk.ukuu.org.uk (Alan Cox), pavel@suse.cz (Pavel Machek),
        rusty@rustcorp.com.au (Rusty Russell), linux-kernel@vger.kernel.org
In-Reply-To: <20020521222139.GJ22878@atrey.karlin.mff.cuni.cz> from "Pavel Machek" at May 22, 2002 12:21:39 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AWSq-0001l6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I believe I seen some strange memcpy for PPro (or something that
> obscure) that done out-of-order accesses to trigger prefetch logic. I
> can't find it any more, so I can't be sure...

Its festering quietly in the glibc source tree where all large and 
dubiously justifiable hacks seem to end up

