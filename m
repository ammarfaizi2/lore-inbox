Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290722AbSARPgL>; Fri, 18 Jan 2002 10:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290723AbSARPf7>; Fri, 18 Jan 2002 10:35:59 -0500
Received: from yinyang.hjsoft.com ([205.231.166.38]:53776 "EHLO
	yinyang.hjsoft.com") by vger.kernel.org with ESMTP
	id <S290722AbSARPfv>; Fri, 18 Jan 2002 10:35:51 -0500
Date: Fri, 18 Jan 2002 10:55:49 -0500 (EST)
From: "Mr. Shannon Aldinger" <god@yinyang.hjsoft.com>
Reply-To: god@yinyang.hjsoft.com
To: Rik van Riel <riel@conectiva.com.br>
cc: Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: vm philosophising
In-Reply-To: <Pine.LNX.4.33L.0201180235210.32617-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.40.0201181040230.6104-100000@yinyang.hjsoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Fri, 18 Jan 2002, Rik van Riel wrote:

> On Fri, 18 Jan 2002, Bosko Radivojevic wrote:
>
> > There is no way to make one good VM for all possible situations. But,
> > you can tune/make one VM to work great on large DBMS (e.g.) and
> > tune/make another one to work great on ordinary desktop systems
>
> This is an interesting assertion ... but up to date nobody has
> been able to tell me what exactly should be different between
> these two mythical VMs ;)
>
I can see two different "VMs". I say "VMs" because it could be the same
code with different magic numbers to control its behavior.

>From a file & database point of view throughput is the most crictical
aspect. Both disk and network throughput. Interactive response on such
systems isn't as critical as most of the time it will sit there processing
queries or sending files.

>From a desktop point of view interactive response is critical, however
disk and network throughput also have to have a fine balance. Maybe the
balance is three way here between interactive response, disk throughput
and network throughput.

Perhaps having a VM system that you select your main focus server vs
desktop would be the way to go. Also the end-user should be able to adjust
this balance. Say a person selected desktop, and is a graphic artist, they
may not care as much about network thoroughput and rather push up
interactive response and disk throughput at the expense of the network
thoroughput.

Regards.
PS: IANAVMP (I Am Not A VM Programmer)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjxIRZAACgkQwtU6L/A4vVDUTQCdG4Pg4hYGPvRXN9kBVfDyWBbD
bnsAnigMlPA21izLJUhKjZcTeeaaK9IC
=EKri
-----END PGP SIGNATURE-----


