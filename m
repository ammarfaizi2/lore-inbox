Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316869AbSEWQDP>; Thu, 23 May 2002 12:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316873AbSEWQDO>; Thu, 23 May 2002 12:03:14 -0400
Received: from zeus.kernel.org ([204.152.189.113]:42626 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S316869AbSEWQDM>;
	Thu, 23 May 2002 12:03:12 -0400
Date: Thu, 23 May 2002 12:03:03 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.4 VM sucks. Again
Message-ID: <20020523120303.N1436@sventech.com>
In-Reply-To: <200205231311.g4NDBO613726@mail.pronto.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2002, Roy Sigurd Karlsbakk <roy@karlsbakk.net> wrote:
> I've been here complaining about the 2.4 VM before, and here I am, back again.
> 
> PROBLEM:
> ----------------------
> Starting up 30 downloads from a custom HTTP server (or Tux - or Apache - 
> doesn't matter), file size is 3-6GB, download speed = ~4.5Mbps. After some 
> time the kernel (a) goes bOOM (out of memory) if not having any swap, or (b) 
> goes gong swapping out anything it can.
> 
> The custom HTTP server processes each have a static buffer of two megabytes, 
> no malloc()s, and are written in < 1000 lines of C.
> 
> Theory: The buffer fills up, as the clients can't read as fast as kernel is 
> reading from disk, and the server goes boom
> 
> thanks for any help

What kernel is this?

JE

