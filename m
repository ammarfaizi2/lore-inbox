Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262707AbSI1EhU>; Sat, 28 Sep 2002 00:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262715AbSI1Efk>; Sat, 28 Sep 2002 00:35:40 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:54920 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S262714AbSI1Efa>; Sat, 28 Sep 2002 00:35:30 -0400
Date: Fri, 27 Sep 2002 23:48:33 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Stephen Tweedie <sct@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch 6/7] 2.4.20-pre4/ext3: jbd commit interval tuning
In-Reply-To: <200209261355.g8QDtWh17010@sisko.scot.redhat.com>
Message-ID: <Pine.LNX.4.44.0209272346380.17618-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Sep 2002, Stephen Tweedie wrote:

> Allow an arbitrary commit interval to be set when mounting or remounting
> a filesystem.
>
> Note that if this is greater than the system bdflush interval, then the
> regular sync()s will beat the commit timer and you won't get longer
> commit timeouts.

Applied. For 2.5 we probably want all fs'es to have the same string to set
the commit interval.

