Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261590AbSJJOMo>; Thu, 10 Oct 2002 10:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261593AbSJJOMo>; Thu, 10 Oct 2002 10:12:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3343 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261590AbSJJOMn>;
	Thu, 10 Oct 2002 10:12:43 -0400
Message-ID: <3DA58C1E.3090102@pobox.com>
Date: Thu, 10 Oct 2002 10:18:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: linux kernel conf 0.8
References: <Pine.LNX.4.44.0210100035210.338-100000@serv>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Hi,
> 
> On Wed, 9 Oct 2002, Jeff Garzik wrote:
> 
> 
>>Which implies that the equivalent of "source drivers/net/Config*"
>>(wildcarding) in Roman's system would be useful.  Or maybe "source
>>drivers/net" and it knows that when given a directory it should scan for
>>all Config* files in that dir.
> 
> 
> This makes dependency checking problematic, as we constantly have to
> check for new config files. How would I teach make/kbuild this?


I won't answer the question, but instead pose a future problem:  if 
drivers are to be added without patching anything, that implies that the 
kbuild makefile rules for the driver are also added without patching.

Personally I don't care about Config dependency checking...  they are 
not modified often enough to affect me, and even if they did, dependency 
checking based on changes to Config files can get ugly, AFAICS.  I just 
do a "bk -r co -Sq" and am done with it...

I didn't say life was easy ;-) ;-)

	Jeff



