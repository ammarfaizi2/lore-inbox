Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbSJHQkv>; Tue, 8 Oct 2002 12:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261497AbSJHQkv>; Tue, 8 Oct 2002 12:40:51 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:1416 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261495AbSJHQku>; Tue, 8 Oct 2002 12:40:50 -0400
Date: Tue, 8 Oct 2002 13:46:18 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: "J.A. Magallon" <jamagallon@able.es>
Cc: procps-list@redhat.com, <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] procps 2.0.10
In-Reply-To: <20021008160210.GA3268@werewolf.able.es>
Message-ID: <Pine.LNX.4.44L.0210081345560.1909-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2002, J.A. Magallon wrote:

> >Yup, that's the bug I fixed friday.  Wait a moment, I fixed
> >it for five_cpu_numbers(), but probably not for the SMP CPU
> >code in top.c itself ...
>
> I swear, I had not seen five_cpu_numbers when I sent you the patch
> about 0.1%...

But that code is used on UP systems.  I forgot to do the same
fix for SMP...

Rik
-- 
A: No.
Q: Should I include quotations after my reply?

http://www.surriel.com/		http://distro.conectiva.com/

