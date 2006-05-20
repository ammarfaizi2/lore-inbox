Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbWETWON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbWETWON (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 18:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbWETWON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 18:14:13 -0400
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:3828 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S932395AbWETWOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 18:14:12 -0400
Message-ID: <446F9399.7050101@comcast.net>
Date: Sat, 20 May 2006 18:09:29 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060518)
MIME-Version: 1.0
To: Kyle McMartin <kyle@mcmartin.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: IA-32 on x86-64
References: <446F138F.4020801@comcast.net> <20060520214101.GA8413@tachyon.int.mcmartin.ca>
In-Reply-To: <20060520214101.GA8413@tachyon.int.mcmartin.ca>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Kyle McMartin wrote:
> On Sat, May 20, 2006 at 09:03:11AM -0400, John Richard Moser wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Does anyone know how to check if I'm running an IA-32 process on x86-64?
> 
> is_compat_task()
> 
>>  More importantly, how do I tell how big the user VM space is for
>> current?  Like 3GiB for x86 and who knows what (87GiB?  192GiB?) for
>> x86-64 and however much for sparc/ppc ....
> 
> TASK_SIZE
> 
> You should probably do your own work instead of posting questions everytime
> you hit something you'd have to do a little bit of searching for.
> 

Noted.  As of late I've had the excuse that I've posted my last question
just before I had to go to bed so everyone else would search for the
answer while I sleep; but point taken ;)

> --
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRG+TmAs1xW0HCTEFAQKtBw/9Gia5K8GLmFo9WB1ePhzfb/tTug/clpoH
iU0AEQgBoFOImKCXLliTdD4r/lr6a68nBei3Aseu9Son0VnIOiB+dI/BuYcpOdN6
b5EdZE9D6vCBR1YHeaMr2lkL6LROlHS4nkb0GPo0IKgWEjhumiK1XK8ojqKQpmh+
2EJ4a0M68LSZJWbw1q58DcAsMACKwj2xtDpcjZsrCRMYwxLrP7wYx3bU6XKiKX2L
u14Q8gMYNaYBYGLm0O7q0AwTwNT+i/tDWtnnuqUCZxiLtTWCLHstZBALEgW2WB6+
pEa+z/JdCuET9Zl3dvqH+5HsJJ7s9tuQA7svDgmatxZ5m0olWFI1Dlg4No2cwoQX
4y2q+a+gYdvgw4BUIh2Tf0XcJ10Sr6turdQc4YoNq2riB5JSH7MS6qedhU38eEKz
30jWv9yRl2CnVn5AzQHWICae4cSMaOP8KxkG3W9fbxJAur3yoAZVz+M3LecNNg5j
GNbObd0COkJTem/eMTsT53WISGkaNG1kDPAkWQZqrusKNXelBwEhjaPhJj/K6isx
v75+S+tJg0gW2mVBxHIw006Z44MnSU6nde9fD+o0C6J8uR42gGHHP2oCTsvtuMQb
6samg/keoAbeXAj3IaL7AgFp+V749U4ISK+3gl1nTxzSnlik4Y6YZ6IT6c1PCQX1
qzhSB5RpOgI=
=NG+P
-----END PGP SIGNATURE-----
