Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316756AbSFJHz7>; Mon, 10 Jun 2002 03:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316759AbSFJHz6>; Mon, 10 Jun 2002 03:55:58 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:15878 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S316756AbSFJHz6>; Mon, 10 Jun 2002 03:55:58 -0400
Message-ID: <3D045B85.16136535@aitel.hist.no>
Date: Mon, 10 Jun 2002 09:55:49 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.20-dj3 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futex Asynchronous Interface
In-Reply-To: <Pine.LNX.4.44.0206091056550.13459-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On 9 Jun 2002, Kai Henningsen wrote:
> >
> > However, I don't think that's all that important. What I'd rather see is
> > making the network devices into namespace nodes. The situation of eth0 and
> > friends, from a Unix perspective, is utterly unnatural.
> 
> But what would you _do_ with them? What would be the advantage as compared
> to the current situation?

Not much, but 
ls /dev/net
eth0 eth1 eth2 ippp0
would be a convenient way to see what net devices exists.
This already works for other devices, when using devfs.

I guess this isn't reason enough though.

Helge Hafting
