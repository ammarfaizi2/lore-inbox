Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932625AbWAKX0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932625AbWAKX0O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 18:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbWAKX0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 18:26:14 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:42880 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932625AbWAKX0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 18:26:13 -0500
Date: Thu, 12 Jan 2006 00:26:09 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ben Collins <ben.collins@ubuntu.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/15] kconf: Check for eof from input stream.
In-Reply-To: <1136814126.1043.36.camel@grayson>
Message-ID: <Pine.LNX.4.61.0601120019430.30994@scrub.home>
References: <0ISL003ZI97GCY@a34-mta01.direcway.com> <200601090109.06051.zippel@linux-m68k.org>
 <1136779153.1043.26.camel@grayson> <200601091232.56348.zippel@linux-m68k.org>
 <1136814126.1043.36.camel@grayson>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 9 Jan 2006, Ben Collins wrote:

> > That just means Debian's automatic build for the kernel has been broken for 
> > years. All normal config targets require user input and no input equals 
> > default input. Only silentoldconfig will abort if input is not available.
> 
> I think that's broken (because I don't see where that behavior is
> described).

I'll accept a patch to fix the documentation.

> IMO, based on the code, it should only go with defaults when
> -n -y or -m is passed.

No.

> Why is it so hard to error when stdin is closed? It's not like that will
> break anything.

oldconfig & co are interactive targets, so don't use them in automatic 
builds. If you some problem with using silentoldconfig, describe it and 
I'll help to solve it.

bye, Roman
