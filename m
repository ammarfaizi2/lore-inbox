Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316634AbSFDNDy>; Tue, 4 Jun 2002 09:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317494AbSFDNDx>; Tue, 4 Jun 2002 09:03:53 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:57786 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S316634AbSFDNDw>; Tue, 4 Jun 2002 09:03:52 -0400
Date: Tue, 4 Jun 2002 14:35:20 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Thunder from the hill <thunder@ngforever.de>
Cc: Scott Murray <scottm@somanetworks.com>,
        Lightweight patch manager <patch@luckynet.dynu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] Port opl3sa2 changes from 2.4
In-Reply-To: <Pine.LNX.4.44.0206031709370.3833-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.44.0206041431480.19645-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jun 2002, Thunder from the hill wrote:

> His patch won't match for 2.5. I just adapted it, even though I've had a 
> typo there.

That would be because the one in 2.5 is quite a few revisions behind 
(perhaps 2-3 patches)

> > > +		opl3sa2_state[card].activated = 1;
> > 
> > This line should really be below the following if statement, as I believe
> > Zwane mentioned to Gerald.
> 
> You could of course have it there. No problem with that.

If you put it there you'd have to unset it on a failure path.

Regards,
	Zwane Mwaikambo
--
http://function.linuxpower.ca
		


