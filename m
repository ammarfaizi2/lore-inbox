Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264279AbTGHPxH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 11:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267482AbTGHPxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 11:53:07 -0400
Received: from marblerye.cs.uga.edu ([128.192.101.172]:20096 "HELO
	marblerye.cs.uga.edu") by vger.kernel.org with SMTP id S264279AbTGHPxE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 11:53:04 -0400
To: Andy Pfiffer <andyp@osdl.org>
Cc: fastboot@osdl.org,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: maybe: kexec + e100 + CONFIG_PM != working
From: Ed L Cashin <ecashin@uga.edu>
Date: Tue, 08 Jul 2003 12:07:40 -0400
In-Reply-To: <1057179998.4341.22.camel@andyp.pdx.osdl.net> (Andy Pfiffer's
 message of "02 Jul 2003 14:06:38 -0700")
Message-ID: <877k6tf1df.fsf@uga.edu>
User-Agent: Gnus/5.090014 (Oort Gnus v0.14) Emacs/21.2
 (i386-debian-linux-gnu)
References: <20030626120244.B29672@atlas.cs.uga.edu>
	<1056753599.1200.53.camel@andyp.pdx.osdl.net> <87k7b2q6mt.fsf@uga.edu>
	<87d6gtrjjs.fsf@uga.edu> <1057179998.4341.22.camel@andyp.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Pfiffer <andyp@osdl.org> writes:

> On Tue, 2003-07-01 at 15:03, Ed L Cashin wrote:
>> Ed L Cashin <ecashin@uga.edu> writes:
>> 
>> ...
>> > I haven't tried the experiment you suggested where I disable e100 in
>> > the kernel configuration.
>> 
>> OK, I just tried taking out the intel e100 driver and building in
>> Becker's eepro100 driver.  This kernel can do kexec fine.
>
> I just had lunch with someone that knows a lot more about the e100
> driver than I do.
>
> I would be curious to know what happens if you disable CONFIG_PM (as
> seen in your .config), disable the eepro100 driver, re-enable the e100
> driver, and then try kexec again.

Yes, kexec works on the same system when I disable CONFIG_PM and use
the e100 driver.  Sorry it took a while for me to get around to
testing it.

I should mention that the kernel is a little different than the other
one I was using.  It's 2.5.73-osdl3 with this .config file:

  http://www.cs.uga.edu/~cashin/temp/config-2.5.73-osdl3-20030708-120629

-- 
--Ed L Cashin            |   PGP public key:
  ecashin@uga.edu        |   http://noserose.net/e/pgp/

