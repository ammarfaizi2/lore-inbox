Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290594AbSAREc6>; Thu, 17 Jan 2002 23:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290593AbSAREcs>; Thu, 17 Jan 2002 23:32:48 -0500
Received: from falcon.etf.bg.ac.yu ([147.91.8.233]:42892 "EHLO
	falcon.etf.bg.ac.yu") by vger.kernel.org with ESMTP
	id <S290592AbSAREck>; Thu, 17 Jan 2002 23:32:40 -0500
Date: Fri, 18 Jan 2002 05:30:33 +0100 (CET)
From: Bosko Radivojevic <bole@falcon.etf.bg.ac.yu>
To: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
cc: Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: Rik spreading bullshit about VM
In-Reply-To: <20020117000758.GL10175@arthur.ubicom.tudelft.nl>
Message-ID: <Pine.LNX.4.33.0201180522020.19716-100000@falcon.etf.bg.ac.yu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 17 Jan 2002, Erik Mouw wrote:

> Some time ago Linus made the important observation that we shouldn't
> tune the scheduler for SMP systems simply because 99.9% of the systems
> in the world running linux have a single CPU. IMHO an equally well
> observation would be that we shouldn't tune the VM for the 0.1% of the
> systems in this world that run large DMBSes. The 99.9% majority is much
> more important.

There is a way to fulfill both needs. If my systems are part of that 0.1%,
I have to disagree with you. :)

There is no way to make one good VM for all possible situations. But, you
can tune/make one VM to work great on large DBMS (e.g.) and tune/make
another one to work great on ordinary desktop systems (playing mp3s & co).
So, add different VMs as kernel-config options. The 'default' one should
be VM for 99.9% users. Everybody happy? :)

Greetings


