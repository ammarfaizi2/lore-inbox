Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264595AbSIVWtY>; Sun, 22 Sep 2002 18:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264594AbSIVWtX>; Sun, 22 Sep 2002 18:49:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56591 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264593AbSIVWtV>;
	Sun, 22 Sep 2002 18:49:21 -0400
Message-ID: <3D8E4A06.5010603@mandrakesoft.com>
Date: Sun, 22 Sep 2002 18:53:58 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
CC: Roman Zippel <zippel@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] linux kernel conf 0.6
References: <Pine.LNX.4.44.0209221744150.11808-100000@chaos.physics.uiowa.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski wrote:
> On Sun, 22 Sep 2002, Jeff Garzik wrote:
> 
> 
>>One cosmetic thing I mentioned to Roman, Config.new needs to be changed 
>>to something better, like conf.in or build.conf or somesuch.
> 
> 
> I agree. (But I'm not particularly good at coming up with names ;) 
> build.conf is maybe not too bad considering that there may be a day where 
> it is extended to support "<driver>.conf" as well.

We want to make sure the config format is extensible in case we want to 
add Makefile rules or some other metadata (i.e. <driver>.conf contains 
all config/make info needed to build a driver, just drop it in)


> One other thing I wanted to mention but forgot was that lkc now
> does a quiet "make oldconfig" when .config changed or does not exist, 
> which is changed behavior.


Can you elaborate a bit on that?  'make oldconfig' is one of the things 
we want to keep working as-is...  That was a downside of ESR's system. 
If you're saying "silent" as in, if-no-changes-occurred or 
defconfig-copied-as-is, that's cool...

	Jeff



