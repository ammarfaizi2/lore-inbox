Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319198AbSIDOhm>; Wed, 4 Sep 2002 10:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319197AbSIDOhm>; Wed, 4 Sep 2002 10:37:42 -0400
Received: from jalon.able.es ([212.97.163.2]:39836 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S319198AbSIDOhl>;
	Wed, 4 Sep 2002 10:37:41 -0400
Date: Wed, 4 Sep 2002 16:41:54 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Remco Post <r.post@sara.nl>, morten.helgesen@nextframe.net,
       linux-kernel@vger.kernel.org
Subject: Re: writing OOPS/panic info to nvram?
Message-ID: <20020904144154.GE1949@werewolf.able.es>
References: <E471FA7E-C00E-11D6-A20D-000393911DE2@sara.nl> <20020904140856.GA1949@werewolf.able.es> <1031149539.2788.120.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <1031149539.2788.120.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Wed, Sep 04, 2002 at 16:25:39 +0200
X-Mailer: Balsa 1.4.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.09.04 Alan Cox wrote:
>On Wed, 2002-09-04 at 15:08, J.A. Magallon wrote:
>> Instead of swap, let user specify a partition to raw dump there. If a user
>> wants crash dumps, he has to leave some small disk space free and give an
>> option like "dump=/dev/hda7".
>
>With what will you write it - not the linux block layer thats for sure.
>Ingo has patches for doing network dumps which are kind of neat
>

Ah, ther is no way to write raw blocks at a very low level to disk...??
LKCD at least writes to a floppy, doesn't it.?
Say you just need one block for the dump. Could you get the block location
(H/C/S) on boot and tell the bios to write a chunk there on crash ?

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.0 (Cooker) for i586
Linux 2.4.20-pre5-j0 (gcc 3.2 (Mandrake Linux 9.0 3.2-1mdk))
