Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284857AbRLRTtn>; Tue, 18 Dec 2001 14:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284860AbRLRTsJ>; Tue, 18 Dec 2001 14:48:09 -0500
Received: from h24-70-162-27.wp.shawcable.net ([24.70.162.27]:13200 "EHLO
	ubb.apia.dhs.org") by vger.kernel.org with ESMTP id <S284849AbRLRTql>;
	Tue, 18 Dec 2001 14:46:41 -0500
Message-Id: <v04003a12b8454bdc0779@[24.70.162.28]>
In-Reply-To: <20011218.113725.82100134.davem@redhat.com>
In-Reply-To: <v04003a11b84549aa834a@[24.70.162.28]>
 <20011215.220646.69411478.davem@redhat.com>
 <20011218190621.A28147@buzz.ichilton.local>
 <v04003a11b84549aa834a@[24.70.162.28]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Organisation: Judean People's Front; Department of Whips, Chains, Thumb-Screws, Six Tons of Whipping Cream, the Entire Soprano Section of the Mormon Tabernacle Choir and Guest Apperances of Eva Peron aka Eric Conspiracy Secret Laboratories
X-Disclaimer-1: This message has been edited from it's original form by members of the Eric Conspiracy.
X-Disclaimer-2: There is no Eric Conspiracy.
X-Not-For-Humans: aardvark@apia.dhs.org and zebra@apia.dhs.org are spamtraps.
Date: Tue, 18 Dec 2001 13:46:03 -0600
To: "David S. Miller" <davem@redhat.com>
From: "Tony 'Nicoya' Mantler" <nicoya@apia.dhs.org>
Subject: Re: 2.4.17-rc1 wont do nfs root on Javastation
Cc: ian@ichilton.co.uk, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 1:37 PM -0600 12/18/01, David S. Miller wrote:
>   From: "Tony 'Nicoya' Mantler" <nicoya@apia.dhs.org>
>   Date: Tue, 18 Dec 2001 13:32:00 -0600
>
>   I really think it should be a compile-time option to have it default to on,
>   but I never figured out who maintains it.
>
>How then would you get a generic, yet NFS-ROOT capable kernel?
>Answer: you can't

Compile-time *Option*, as in "IP-Autoconfig default to on: (yes/no)".

If you need to build a kernel generica for a platform where you can pass a
commandline easily, you just leave it at 'no', and get the same behaviour
as current.

If you need to build a kernel to nfsroot on a platform where setting a
commandline is difficult or impossible (like javastation), set it to 'yes',
and get a working nfsroot.

Simple.


Alternatley, having a configuration option to set a commandline, like some
other arches have, would also work.


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


