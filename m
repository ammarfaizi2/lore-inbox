Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbVI2BGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbVI2BGW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 21:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbVI2BGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 21:06:22 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:15877 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S932069AbVI2BGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 21:06:21 -0400
Message-ID: <433B3DDF.8090908@tuxrocks.com>
Date: Wed, 28 Sep 2005 19:05:35 -0600
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@elte.hu,
       akpm@osdl.org, george@mvista.com, paulmck@us.ibm.com, hch@infradead.org,
       oleg@tv-sign.ru, zippel@linux-m68k.org, tim.bird@am.sony.com
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
References: <20050928224419.1.patchmail@tglx.tec.linutronix.de>	 <433B2E62.5050201@tuxrocks.com>  <433B3A52.30803@tuxrocks.com> <1127955398.8195.255.camel@cog.beaverton.ibm.com>
In-Reply-To: <1127955398.8195.255.camel@cog.beaverton.ibm.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

john stultz wrote:
> On Wed, 2005-09-28 at 18:50 -0600, Frank Sorenson wrote:
> 
>>Frank Sorenson wrote:
>>
>>>I get this kernel panic on boot (serial capture) with the latest
>>>git tree (2.6.14-rc2++) plus this version of ktimers:
>>
>>Here's a little more information.  I've narrowed the panic down to ntpd
>>startup.  Without ntpd, the system seems to run okay, but panics the
>>moment I startup ntpd.
> 
> 
> Are you just testing the ktimers patch or the full set of patches Thomas
> is working with (including my code)?
> 
> thanks
> -john

After first testing with other patches, I verified that the panic occurs
without any other patches involved.

So, I am just testing this particular ktimers patch, without any others.

Am I correct in my understanding that this patch is standalone?

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDOz3faI0dwg4A47wRAn+/AKDsu/lRzUhbln8pNoRpfZ2V45D0NgCfQLHF
lK6+uXzWFQQhp8SvqBxPw1M=
=B9oy
-----END PGP SIGNATURE-----
