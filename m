Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314295AbSEXKgk>; Fri, 24 May 2002 06:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317122AbSEXKgj>; Fri, 24 May 2002 06:36:39 -0400
Received: from [62.70.58.70] ([62.70.58.70]:59288 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S314295AbSEXKgj> convert rfc822-to-8bit;
	Fri, 24 May 2002 06:36:39 -0400
Message-Id: <200205241036.g4OAaXR28572@mail.pronto.tv>
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: Pronto TV AS
To: jlnance@intrex.net, linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.4 VM sucks. Again
Date: Fri, 24 May 2002 12:36:32 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <200205231311.g4NDBO613726@mail.pronto.tv> <20020523141243.A1178@tricia.dyndns.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 May 2002 20:12, jlnance@intrex.net wrote:
> On Thu, May 23, 2002 at 03:11:24PM +0200, Roy Sigurd Karlsbakk wrote:
> > Starting up 30 downloads from a custom HTTP server (or Tux - or Apache -
> > doesn't matter), file size is 3-6GB, download speed = ~4.5Mbps. After
> > some time the kernel (a) goes bOOM (out of memory) if not having any
> > swap, or (b) goes gong swapping out anything it can.
>
> Does this work if the client and the server are on the same machine?  It
> would make reproducing this a lot easier if it only required 1 machine.

I guess it'd work fine with only one machine, as IMO, the problem must be the 
kernel not releasing buffers
-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.
