Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318810AbSIDOFC>; Wed, 4 Sep 2002 10:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318859AbSIDOFC>; Wed, 4 Sep 2002 10:05:02 -0400
Received: from jalon.able.es ([212.97.163.2]:41626 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S318810AbSIDOFC>;
	Wed, 4 Sep 2002 10:05:02 -0400
Date: Wed, 4 Sep 2002 16:08:56 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Remco Post <r.post@sara.nl>
Cc: morten.helgesen@nextframe.net, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: writing OOPS/panic info to nvram?
Message-ID: <20020904140856.GA1949@werewolf.able.es>
References: <E471FA7E-C00E-11D6-A20D-000393911DE2@sara.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E471FA7E-C00E-11D6-A20D-000393911DE2@sara.nl>; from r.post@sara.nl on Wed, Sep 04, 2002 at 16:02:04 +0200
X-Mailer: Balsa 1.4.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.09.04 Remco Post wrote:
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>
>On woensdag, september 4, 2002, at 02:54 , Morten Helgesen wrote:
>
>> On Wed, Sep 04, 2002 at 01:49:12PM +0100, Alan Cox wrote:
>>> On Wed, 2002-09-04 at 13:31, Morten Helgesen wrote:
>>>> True - the 'normal' size on a PC is apparently something like 114 
>>>> bytes ...
>>>> I  guess we could use it for something useful ... but maybe not for
>>>> OOPSen/panics.
>>>>
>>>> I didn`t realize we only had 114 bytes to work with.
>>>
>>> We don't. They are all used by the BIOS
>>
>> That makes it even less useful. Oh well.
>>
>
>For PC style hardware it does. For other platforms, it's stil nice to be 
>able to see the oops info on an unattended crash (all crashes? ;) Dump 
>to nvram, dump to file after boot.... Other option is to crash-dump to 
>swap... Question is, do you really want to do that?
>

Instead of swap, let user specify a partition to raw dump there. If a user
wants crash dumps, he has to leave some small disk space free and give an
option like "dump=/dev/hda7".

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.0 (Cooker) for i586
Linux 2.4.20-pre5-j0 (gcc 3.2 (Mandrake Linux 9.0 3.2-1mdk))
