Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280819AbRKTDJQ>; Mon, 19 Nov 2001 22:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280834AbRKTDJG>; Mon, 19 Nov 2001 22:09:06 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53607 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S280819AbRKTDJA>; Mon, 19 Nov 2001 22:09:00 -0500
To: Rik van Riel <riel@conectiva.com.br>
Cc: Erik Gustavsson <cyrano@algonet.se>, <linux-kernel@vger.kernel.org>
Subject: Re: Swap
In-Reply-To: <Pine.LNX.4.33L.0111191642390.1491-100000@duckman.distro.conectiva>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Nov 2001 19:49:58 -0700
In-Reply-To: <Pine.LNX.4.33L.0111191642390.1491-100000@duckman.distro.conectiva>
Message-ID: <m1k7wm6trd.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br> writes:

> On 19 Nov 2001, Eric W. Biederman wrote:
> 
> > > Is there a way to limit the size of the cache?
> >
> > Reasonable.  It looks like the use once heuristics are failing for your
> > mp3 files.   Find out why that is happening and they should push the
> > rest of your system into swap.
> 
> I bet they're getting mmap()d, like all mp3 programs seem to do  ;)

That would probably do it.  Though it is puzzling why after the file
is munmaped it's pages aren't recycled.

Eric
