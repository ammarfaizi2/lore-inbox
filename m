Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290335AbSAXVgV>; Thu, 24 Jan 2002 16:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290334AbSAXVgL>; Thu, 24 Jan 2002 16:36:11 -0500
Received: from svr3.applink.net ([206.50.88.3]:45319 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S290331AbSAXVf7>;
	Thu, 24 Jan 2002 16:35:59 -0500
Message-Id: <200201242130.g0OLSrL06629@home.ashavan.org.>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: Fix MTRR handling on HT CPUs (improved)
Date: Fri, 25 Jan 2002 15:30:22 -0600
X-Mailer: KMail [version 1.3.2]
Cc: Richard Gooch <rgooch@atnf.csiro.au>,
        Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0201242145400.1046-100000@biker.pdb.fsc.net>
In-Reply-To: <Pine.LNX.4.33.0201242145400.1046-100000@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 January 2002 14:57, Martin Wilck wrote:
> On Intel processors with "Jackson" technology (also HT, HyperThreading),
> two logical processors share certain registers, in particular the MTRR
> registers. The Linux way of manipulating these registers may lead to
> inconsistent MTRR settings or total disabling of cache.

I thought that Intel was purposely downplaying HT support on the
processors due to performance issues  and M$ didn't support it
likewise.  Is this another case of Linux being out in the front of things?
Are you to a point that you can benchmark it and recommend when
to enable it or not?

-- 
timothy.covell@ashavan.org.
