Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284557AbRLRTfy>; Tue, 18 Dec 2001 14:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284766AbRLRTeN>; Tue, 18 Dec 2001 14:34:13 -0500
Received: from h24-70-162-27.wp.shawcable.net ([24.70.162.27]:11152 "EHLO
	ubb.apia.dhs.org") by vger.kernel.org with ESMTP id <S284787AbRLRTci>;
	Tue, 18 Dec 2001 14:32:38 -0500
Message-Id: <v04003a11b84549aa834a@[24.70.162.28]>
In-Reply-To: <20011218190621.A28147@buzz.ichilton.local>
In-Reply-To: <20011215.220646.69411478.davem@redhat.com>
 <20011214181816.B28794@woody.ichilton.co.uk>
 <20011215.220646.69411478.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Organisation: Judean People's Front; Department of Whips, Chains, Thumb-Screws, Six Tons of Whipping Cream, the Entire Soprano Section of the Mormon Tabernacle Choir and Guest Apperances of Eva Peron aka Eric Conspiracy Secret Laboratories
X-Disclaimer-1: This message has been edited from it's original form by members of the Eric Conspiracy.
X-Disclaimer-2: There is no Eric Conspiracy.
X-Not-For-Humans: aardvark@apia.dhs.org and zebra@apia.dhs.org are spamtraps.
Date: Tue, 18 Dec 2001 13:32:00 -0600
To: Ian Chilton <ian@ichilton.co.uk>, "David S. Miller" <davem@redhat.com>
From: "Tony 'Nicoya' Mantler" <nicoya@apia.dhs.org>
Subject: Re: 2.4.17-rc1 wont do nfs root on Javastation
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 1:06 PM -0600 12/18/01, Ian Chilton wrote:
[...]
>Now when it boots, it says "Kernel command line: root=nfs" but still,
>the kernel does not try and do the IP-Config/bootp stuff so it fails
>saying it can't find the NFS server which is obvious as it doesn't have
>an ip etc...
[...]

IP Autoconfig won't be enabled unless you pass ip=auto in the commandline,
or twiddle with the source to make it default to on.

I really think it should be a compile-time option to have it default to on,
but I never figured out who maintains it.


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


