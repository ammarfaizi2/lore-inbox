Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317002AbSFAMhE>; Sat, 1 Jun 2002 08:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317011AbSFAMhD>; Sat, 1 Jun 2002 08:37:03 -0400
Received: from [62.70.58.70] ([62.70.58.70]:60296 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S317002AbSFAMhD> convert rfc822-to-8bit;
	Sat, 1 Jun 2002 08:37:03 -0400
Message-Id: <200206011236.g51CauY15367@mail.pronto.tv>
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: Pronto TV AS
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: [BUG] 2.4 VM sucks. Again
Date: Sat, 1 Jun 2002 14:36:56 +0200
X-Mailer: KMail [version 1.3.1]
Cc: jlnance@intrex.net, linux-kernel@vger.kernel.org
In-Reply-To: <200205231311.g4NDBO613726@mail.pronto.tv> <200205241036.g4OAaXR28572@mail.pronto.tv> <20020531212133.GA1172@dualathlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I guess it'd work fine with only one machine, as IMO, the problem must be
> > the kernel not releasing buffers
>
> too much variable.
>
> Also keep in mind if you grow the socket buffer to hundred mbyte on an
> highmem machine the zone-normal will finish too fast and you may run out
> of memory. 2.4.19pre9aa2 in such case should at least return -ENOMEM and
> not deadlock.

it's not a highmem machine. And. It's not user space processes using the 
memory
-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.
