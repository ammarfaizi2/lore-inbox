Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289243AbSA1Q4x>; Mon, 28 Jan 2002 11:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289250AbSA1Q4m>; Mon, 28 Jan 2002 11:56:42 -0500
Received: from nrg.org ([216.101.165.106]:26160 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S289243AbSA1Q4g>;
	Mon, 28 Jan 2002 11:56:36 -0500
Date: Mon, 28 Jan 2002 08:56:25 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Alex Davis <alex14641@yahoo.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Don't use dbench for benchmarks
In-Reply-To: <Pine.LNX.3.95.1020128100010.15936A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.40.0201280852420.11243-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2002, Richard B. Johnson wrote:
> It seems that compiling the Linux Kernel while burning a CDROM gives
> a good check of "acceptable" performance. But, such operations are
> not "benchmarks". The trick is to create a benchmark that performs
> many "simultaneous" independent and co-dependent operations using
> I/O devices that everyone is likely to have. I haven't seen anything
> like this yet.
>
> Such a benchmark might have multiple tasks performing things like:
>
> (1)	Real Math on large arrays.
>
> (2)	Data-base indexed lookups.
>
> (3)	Data-base keys sorting.
>
> (4)	Small file I/O with multiple creations and deletions.
>
> (5)	Large file I/O operations with many seeks.
>
> (6)	Multiple "network" Client/Server tasks through loop-back.
>
> (7)	Simulated compiles by searching directory trees for
> 	"include" files, reading them and closing them, while
> 	performing string-searches to simulate compiler parsing.
>
> (8)	Two or more tasks communicating using shared-RAM. This
> 	can be a "nasty" performance hog, but tests the performance
> 	of threaded applications without having to write those
> 	applications.
>
> (9)	And more....
>
>
> These tasks would be given a "performance weighting value", a heuristic
> that relates to perceived overall performance.

It sounds like you are describing the Aim Benchmark suite, which has
been used for years to compare unix system performancem, and was
recently released under the GPL by Caldera.

See http://caldera.com/developers/community/contrib/aim.html

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

