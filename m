Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293082AbSB1Oi3>; Thu, 28 Feb 2002 09:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293302AbSB1Ofz>; Thu, 28 Feb 2002 09:35:55 -0500
Received: from fungus.teststation.com ([212.32.186.211]:3855 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S293337AbSB1Oe5>; Thu, 28 Feb 2002 09:34:57 -0500
Date: Thu, 28 Feb 2002 15:34:53 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: Cyrille Chepelov <cyrille@chepelov.org>
cc: <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Christian_Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
Subject: Re: [2.4.18] OOPS in smbfs 
In-Reply-To: <20020227080024.GA16232@calixo.net>
Message-ID: <Pine.LNX.4.33.0202281507560.32098-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2002, Cyrille Chepelov wrote:

> I did nothing special at the time; I had just mounted the device, and was
> tab-completing into a directory using zsh (there are no specially named files 
> at all in that directory: everything matches [0-9a-zA-Z._]). The server is a 
> fairly storyless NT4.0 x86 server (I'm not quite sure what service pack, and 
> wouldn't be surprised if it was  still at SP0).
> 
> Kernel version is 2.4.18-rc4

There is a bunch of smbfs changes in 2.4.18. Some fsx fixes from december
and some cleanups from Al Viro. The latter I have not tested myself so I'm
hoping those are causing this and that I will be able to trigger it
easily.

I now have 3 reports of identical oopses in 2.4.18. All of them crashed on
a register with contents matching x0000000 and in smb_fill_cache.


Does 2.4.17 work fine for everyone?
Did any of you try something between 2.4.18-pre4 and 2.4.18-rc2?

2.4.18-pre4 has about half the smbfs changes in 2.4.18 and 2.4.18-rc3 has
the rest. A simple but helpful thing to do would be to see if 2.4.18-rc2
works.

I have planned to actually get to do some linux work this weekend, unlike
the last few weeks, so your timing is pretty good. :)

/Urban

