Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316761AbSEWP30>; Thu, 23 May 2002 11:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316773AbSEWP3Z>; Thu, 23 May 2002 11:29:25 -0400
Received: from [195.63.194.11] ([195.63.194.11]:37133 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316761AbSEWP3Y>; Thu, 23 May 2002 11:29:24 -0400
Message-ID: <3CECFBEE.9010802@evision-ventures.com>
Date: Thu, 23 May 2002 16:25:50 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: gowdy@slac.stanford.edu
CC: Greg KH <greg@kroah.com>, Andre Bonin <kernel@bonin.ca>,
        linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Linux-usb-users@lists.sourceforge.net
Subject: Re: [Linux-usb-users] Re: What to do with all of the USB UHCI drivers
 in the kernel?
In-Reply-To: <Pine.LNX.4.44.0205230746500.1824-100000@router-273.sgowdy.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Stephen J. Gowdy napisa?:
> Hi Martin,
> 	What do you actually want to know? That an EHCI controller should 
> use the ehci-hcd driver and that the OHCI controller should use the 
> ohci-hcd controller? Or that the uhci-* drivers can't drive a EHCI or OHCI 
> controller? Or something else?

Well what I know is the following: Kudzu did set up my system
to use usb-ohci driver similar. And now you have apparently
started to obsolete some of them. I know that there are still
two drivers supported. So I would really really wellcome it
if you would just write up some documentation about the *whole*
transition from using some old driver to the one which is
supposed to be the driver used in the future.

Most likely this would be of course module aliasing entires
which could be used in /etc/modules.conf to cheat around
kudzu  - this way it would be for example possible
to have a nice dual boot configuration.
(I can adjust my boot scripts to set up an apriopriate symlink
from /etc/modules.conf to modules-2.5.18.confg and
modules-2.4.18.conf debpending what I'm booting anyway...)

In short - if you change something about the configuration
and usage - just document it please.

Thank's in advance.

BTW> one of the reasons I never bothered myself with kbuild-2.5
is for example that nio matter how frequently Keith
is advertising it - every time I go there to have a look at it
at sf what I find is a scatter heap of .tar.gz. The documentation
about how to install it makes me nervous, since I would
rather just expect a diff and a README how to use it, so I never
look after it.

