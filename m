Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316592AbSGQTjc>; Wed, 17 Jul 2002 15:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316594AbSGQTjc>; Wed, 17 Jul 2002 15:39:32 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:2293 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316592AbSGQTjc>; Wed, 17 Jul 2002 15:39:32 -0400
Subject: Re: [patch 1/13] minimal rmap
From: Robert Love <rml@tech9.net>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Daniel Phillips <phillips@arcor.de>, Andrew Morton <akpm@zip.com.au>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L.0207171630450.12241-100000@imladris.surriel.com>
References: <Pine.LNX.4.44L.0207171630450.12241-100000@imladris.surriel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 17 Jul 2002 12:42:22 -0700
Message-Id: <1026934942.1086.27.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-17 at 12:31, Rik van Riel wrote:

> > That is not a problem with rmap per se, it's a result of not properly
> > handling streaming IO.
> 
> Umm, updatedb isn't exactly streaming...

Similar properties that warrant similar behavior, though - specifically,
cache and swap behavior ideally would be use-once.

	Robert Love

