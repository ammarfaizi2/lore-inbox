Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315265AbSHVRqa>; Thu, 22 Aug 2002 13:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315267AbSHVRq3>; Thu, 22 Aug 2002 13:46:29 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:2568 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S315265AbSHVRq0>; Thu, 22 Aug 2002 13:46:26 -0400
Date: Thu, 22 Aug 2002 10:48:53 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Tomas Szepe <szepe@pinerecords.com>
cc: Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>,
       Gonzalo Servat <gonzalo@unixpac.com.au>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: ServerWorks OSB4 in impossible state
In-Reply-To: <20020822164527.GA11488@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.10.10208221021480.11626-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It took sometime figure this out with the ASIC architect.
Since there is not an easy way to determine which of the extremely early
SB's had the issue, it is suggested to hit it with a hammer on the DMA
table building.
 
On Thu, 22 Aug 2002, Tomas Szepe wrote:

> > > Yeah I expect to take heat for this one from ServerWorks and it may cost
> > > me later, but nobody else has got the guts to press the issue for the
> > > correct solution.
> > 
> > Let me know if we can help. I have no personal contacts to ServerWorks,
> > but we are a large customer of them and may be able to exert some
> > additional pressure. The current situation (IDE DMA must be disabled)
> > is hardly acceptable for us anyway.
> 
> AFAIK 2.4.18 as well as 2.4.19-preEARLY seemed to work flawlessly w/ OSB4
> even in DMA modes. How's the code there then? Is it dangerous to use?
> 
> T.
> 

Andre Hedrick
LAD Storage Consulting Group

