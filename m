Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318722AbSIDN5u>; Wed, 4 Sep 2002 09:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318789AbSIDN5u>; Wed, 4 Sep 2002 09:57:50 -0400
Received: from mta.sara.nl ([145.100.16.144]:62163 "EHLO mta.sara.nl")
	by vger.kernel.org with ESMTP id <S318722AbSIDN5t>;
	Wed, 4 Sep 2002 09:57:49 -0400
Date: Wed, 4 Sep 2002 16:02:04 +0200
Subject: Re: writing OOPS/panic info to nvram?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
To: morten.helgesen@nextframe.net
From: Remco Post <r.post@sara.nl>
In-Reply-To: <20020904145446.B117@sexything>
Message-Id: <E471FA7E-C00E-11D6-A20D-000393911DE2@sara.nl>
Content-Transfer-Encoding: 7bit
X-Pgp-Agent: GPGMail 0.5.3 (v20)
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


On woensdag, september 4, 2002, at 02:54 , Morten Helgesen wrote:

> On Wed, Sep 04, 2002 at 01:49:12PM +0100, Alan Cox wrote:
>> On Wed, 2002-09-04 at 13:31, Morten Helgesen wrote:
>>> True - the 'normal' size on a PC is apparently something like 114 
>>> bytes ...
>>> I  guess we could use it for something useful ... but maybe not for
>>> OOPSen/panics.
>>>
>>> I didn`t realize we only had 114 bytes to work with.
>>
>> We don't. They are all used by the BIOS
>
> That makes it even less useful. Oh well.
>

For PC style hardware it does. For other platforms, it's stil nice to be 
able to see the oops info on an unattended crash (all crashes? ;) Dump 
to nvram, dump to file after boot.... Other option is to crash-dump to 
swap... Question is, do you really want to do that?

- ---
Met vriendelijke groeten,

Remco Post

SARA - Stichting Academisch Rekencentrum Amsterdam    http://www.sara.nl
High Performance Computing  Tel. +31 20 592 8008    Fax. +31 20 668 3167
PGP keys at http://home.sara.nl/~remco/keys.asc

"I really didn't foresee the Internet. But then, neither did the computer
industry. Not that that tells us very much of course - the computer 
industry
didn't even foresee that the century was going to end." -- Douglas Adams


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (Darwin)

iD8DBQE9dhJkBIoCv9yTlOwRAgG3AJ0SFZCTxz01okoJjlD4QHqNEBJjuACgp6sI
YJloQg8tfaE+677XsT7sq7M=
=p/b2
-----END PGP SIGNATURE-----

