Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316586AbSGQTet>; Wed, 17 Jul 2002 15:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316591AbSGQTet>; Wed, 17 Jul 2002 15:34:49 -0400
Received: from dsl-213-023-038-064.arcor-ip.net ([213.23.38.64]:21694 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316586AbSGQTer>;
	Wed, 17 Jul 2002 15:34:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: [patch 1/13] minimal rmap
Date: Wed, 17 Jul 2002 21:38:29 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L.0207171630450.12241-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.44L.0207171630450.12241-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Uud4-0004PN-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 July 2002 21:31, Rik van Riel wrote:
> On Wed, 17 Jul 2002, Daniel Phillips wrote:
> > On Wednesday 17 July 2002 07:29, Andrew Morton wrote:
> > > 11: The nightly updatedb run is still evicting everything.
> >
> > That is not a problem with rmap per se, it's a result of not properly
> > handling streaming IO.
> 
> Umm, updatedb isn't exactly streaming...

You're right, it's not exactly, it's hitting every directory entry on the 
system, hopefully just once.  Let's not call it streaming, let's call it...
err... use-once? ;-)

-- 
Daniel
