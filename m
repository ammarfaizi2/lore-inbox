Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286732AbRL1DxD>; Thu, 27 Dec 2001 22:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286734AbRL1Dwx>; Thu, 27 Dec 2001 22:52:53 -0500
Received: from white.pocketinet.com ([12.17.167.5]:57326 "EHLO
	white.pocketinet.com") by vger.kernel.org with ESMTP
	id <S286732AbRL1Dwo>; Thu, 27 Dec 2001 22:52:44 -0500
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <nknight@pocketinet.com>
Reply-To: nknight@pocketinet.com
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>, christian e <cej@ti.com>
Subject: Re: minimizing swap usage
Date: Thu, 27 Dec 2001 19:52:48 -0800
X-Mailer: KMail [version 1.3.1]
Cc: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>,
        linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0112200559350.8883-100000@shell1.aracnet.com> <3C2B0A5A.4070101@ti.com> <01122714150100.12566@manta>
In-Reply-To: <01122714150100.12566@manta>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <WHITEidGVwPGxgelXDe00000748@white.pocketinet.com>
X-OriginalArrivalTime: 28 Dec 2001 03:51:07.0918 (UTC) FILETIME=[E1A9DAE0:01C18F52]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 December 2001 08:15 am, vda wrote:
> On Thursday 27 December 2001 09:47, christian e wrote:
> > > I've just installed 2.4.17 and so far it seems better.According
> > > to changelog there has been some changes to swap behaviour.Can I
> > > make it even more aggressive to cut down on buffers+cache somehow
> > > ??
> >
> > sorry ,my bad.After using it for some hours it's just as
> > bad.Rechecked the changelog and it was already done in the previous
> > kernel i used (17-rc1 ).Same problem with lots of cache and plenty
> > of swapping :-(
>
> Ok, let's try to collect some data.
> I ask (knowledgeable) list members to say whether they see something
> unusual
>
> You may find below
> 1) top of my box running normally
> 2) top after killall5 -15; killall5 -9
> 3) /proc/mounts
>
> Why proc/mounts? There you will see that my box is exclusively NFSed.
> AFAIK nfs mounts do not cache large amounts of data on the client
> size. Note that when you try to explain top (2).

You're not understanding. This is not a bug. This is intended behavior. 
The problem is that this behavior is not neccisarily desirable. I have 
attempted to propose something that can be TRIED in order to attempt to 
optimize swap behavior for certain situations, primarily desktop usage.

This is not a bug.
There is nothing unusual about it.
I am not attempting to report a bug.
There is no need to collect data.
We have all the data we need from any number of complaints about 
current swap behavior.
Something needs to be tried, I proposed something to be tried, I did 
not report a bug, I did not say this was unusual for 2.4.x series.
