Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315868AbSEGPZM>; Tue, 7 May 2002 11:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315870AbSEGPZL>; Tue, 7 May 2002 11:25:11 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44561 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315868AbSEGPZK>; Tue, 7 May 2002 11:25:10 -0400
Subject: Re: Tux in main kernel tree? (was khttpd rotten?)
To: andrea@suse.de (Andrea Arcangeli)
Date: Tue, 7 May 2002 16:26:02 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        naclos@andyc.dyndns.org (Andy Carlson), linux-kernel@vger.kernel.org
In-Reply-To: <20020507170331.P31998@dualathlon.random> from "Andrea Arcangeli" at May 07, 2002 05:03:31 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1756qo-0007mw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, May 07, 2002 at 03:42:47PM +0100, Alan Cox wrote:
> > Tux has a lot of other things that make it questionable for merging -
> > incredibly so for 2.4 - it sticks its fingers into task structs, dcache
> 
> I don't buy that, so you may want to give us an answer for why is it
> included into the redhat 2.4 kernel if according to you it's incredibly
> questionable for merging into 2.4?

The Red Hat goal is to provide an extremely high quality tested distribution.
There are several things TuX needs that are stable, and high quality but
which Linus rejected because they put TuX specific code in places like
the dcache where from a pure clean kernel point of view it is 
undesirable.

Alan
