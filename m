Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261211AbSJHPXI>; Tue, 8 Oct 2002 11:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261228AbSJHPXI>; Tue, 8 Oct 2002 11:23:08 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:740 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261211AbSJHPXH>; Tue, 8 Oct 2002 11:23:07 -0400
Date: Tue, 8 Oct 2002 12:05:34 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: "J.A. Magallon" <jamagallon@able.es>
Cc: procps-list@redhat.com, <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] procps 2.0.10
In-Reply-To: <20021008145340.GE1560@werewolf.able.es>
Message-ID: <Pine.LNX.4.44L.0210081204000.1909-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2002, J.A. Magallon wrote:

> >should always be 0.0% and it always is 0.0% here.
> >
> >I have no idea why it's displaying a wrong value on your
> >system, unless you somehow managed to run against a wrong
> >libproc.so (shouldn't happen).
>
> It looks like the 2 first screenshots show buggy data:

Yup, that's the bug I fixed friday.  Wait a moment, I fixed
it for five_cpu_numbers(), but probably not for the SMP CPU
code in top.c itself ...

I'll fix this one after lunch.

thanks,

Rik
-- 
A: No.
Q: Should I include quotations after my reply?

http://www.surriel.com/		http://distro.conectiva.com/

