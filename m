Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbTJJOIz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 10:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbTJJOIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 10:08:55 -0400
Received: from 202-47-55-78.adsl.gil.com.au ([202.47.55.78]:44675 "HELO
	longlandclan.hopto.org") by vger.kernel.org with SMTP
	id S262788AbTJJOIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 10:08:53 -0400
Message-ID: <3F86BD0E.4060607@longlandclan.hopto.org>
Date: Sat, 11 Oct 2003 00:07:10 +1000
From: Stuart Longland <stuartl@longlandclan.hopto.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: lgb@lgb.hu, Fabian.Frederick@prov-liege.be, linux-kernel@vger.kernel.org
Subject: Re: 2.7 thoughts
References: <D9B4591FDBACD411B01E00508BB33C1B01F13BCE@mesadm.epl.prov-liege.be>	<20031009115809.GE8370@vega.digitel2002.hu>	<20031009165723.43ae9cb5.skraw@ithnet.com>	<3F864F82.4050509@longlandclan.hopto.org> <20031010125137.4080a13b.skraw@ithnet.com>
In-Reply-To: <20031010125137.4080a13b.skraw@ithnet.com>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephan von Krawczynski wrote:

> You are obviously not quite familiar with industrial boxes where this is
> state-of-the-art. 
 >
 > [...]
 >
> Generally spoken every part of a computer should be thought of as a "resource"
> that can be added or removed at any time during runtime. CPU or RAM is in no
> way different.

Oh, okay, this sort of thing is supported by industrial boxes? 
Interesting... Live and learn I spose ;-) (You're right, I'm not 
familiar with industrial boxes at all.  My experience is with mostly 
desktop computers, laptops, and some entry-level servers)

Hotplug RAM I could see would be possible, but hotplug CPUs?  I spose if 
you've got a multiprocessor box, you could swap them one at a time, but 
my thinking is that this would cause issues with the OS as it wouldn't 
be expecting the CPU to suddenly disappear.  Problems would be even 
worse if the old and new CPUs were of different types too.

Hotplug RAM would also be interesting, but then again, I spose the 
procedure would be to alert the kernel that the memory area from byte X 
to byte Y would disappear, so it could page that out to swapspace.

Anyways, I don't profess to be any hardware/software/kernel guru, I had 
never heard of this level of hotplug, and it struck me as unusual.
- -- 
+-------------------------------------------------------------+
| Stuart Longland           stuartl at longlandclan.hopto.org |
| Brisbane Mesh Node: 719             http://stuartl.cjb.net/ |
| I haven't lost my mind - it's backed up on a tape somewhere |
| Griffith Student No:           Course: Bachelor/IT (Nathan) |
+-------------------------------------------------------------+
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/hr0OIGJk7gLSDPcRAl9CAJ0c+iU//ELVoO8czbezWgvd7UBzjwCeNApa
ftZkG88NrefELUoGaEop+NI=
=tTfj
-----END PGP SIGNATURE-----

