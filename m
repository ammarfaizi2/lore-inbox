Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266114AbTATP5v>; Mon, 20 Jan 2003 10:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266116AbTATP5v>; Mon, 20 Jan 2003 10:57:51 -0500
Received: from cibs9.sns.it ([192.167.206.29]:30727 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S266114AbTATP5t>;
	Mon, 20 Jan 2003 10:57:49 -0500
Date: Mon, 20 Jan 2003 17:06:48 +0100 (CET)
From: venom@sns.it
To: Oleg Drokin <green@namesys.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: ReiserFS corruption with kernel 2.5.59
In-Reply-To: <20030120172826.A2758@namesys.com>
Message-ID: <Pine.LNX.4.43.0301201654180.2451-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It think it would be quite difficoult to find which sequence of events caused
this corruption.
The first message appeared saturday, while the desktop was just running X,
KDE 3.1 as desktop, (no users conencted or using it), and
the just running application was kslideshow.kss, to lock the desktop, showing
some nice good gif.
But /ust /opt and home of the user running this KDE was not the root partition
that has been corrupted.

also /var is in a different partition.

The only I/O that could be done on / partition was reading the so libraries in
/lib, and some configuration file in /etc.
Then every night updatedb has been runned, reading all partition.

The latest 2.5 kernel I tested on this desktop before 2.5.59 was 2.5.55, and
I am sure the filesystem was not corrupted with 2.5.55, (then I used 2.4.20 for
a while, and no corruption also in this case).


Bests
Luigi


On Mon, 20 Jan 2003, Oleg Drokin wrote:

> Date: Mon, 20 Jan 2003 17:28:26 +0300
> From: Oleg Drokin <green@namesys.com>
> To: venom@sns.it
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: ReiserFS corruption with kernel 2.5.59
>
> Hello!
>
> On Mon, Jan 20, 2003 at 03:23:54PM +0100, venom@sns.it wrote:
> > Yes, it was.
> > Before I started 2.5.59 I was running 2.4.20 with no problems at all.
>
> Hm. Interesting. I will look for the cause.
> Let us know if you'd see this problem again, though (and if you'd be able
> to find what sequence of events caused this to happen, that would be even
> more good).
>
> Thank you.
>
> Bye,
>     Oleg
>

