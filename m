Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262588AbREOAZk>; Mon, 14 May 2001 20:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262590AbREOAZa>; Mon, 14 May 2001 20:25:30 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:38668 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262588AbREOAZ1>; Mon, 14 May 2001 20:25:27 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 2.4.4 kernel reports wrong amount of physical memory
Date: 14 May 2001 17:25:18 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9dpt1e$185$1@cesium.transmeta.com>
In-Reply-To: <200105142250.f4EMoHt02203@adsl-209-76-109-63.dsl.snfc21.pacbell.net> <Pine.LNX.4.33.0105142025000.18102-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.33.0105142025000.18102-100000@duckman.distro.conectiva>
By author:    Rik van Riel <riel@conectiva.com.br>
In newsgroup: linux.dev.kernel
>
> On Mon, 14 May 2001, Wayne Whitney wrote:
> > In mailing-lists.linux-kernel, you wrote:
> >
> > > You need to compile highmem support into the kernel if you want to
> > > use more than 890 MB of RAM, set it to maximum 4GB for best
> > > performance...
> >
> > On a similar note, what is the maximum physical memory supported
> > by the 4GB option?
> 
> Ummm, 4GB maybe? ;)
> 

It seems obvious once you know why the limits are there.  The 1 GB
limit (actually 1024-128 MB = 896 MB) is a software limit; the 4 GB
and 64 GB limits are hardware limits and are exact.

IMO we should rename the 1 GB option!

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
