Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265599AbRFWCkB>; Fri, 22 Jun 2001 22:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265600AbRFWCjw>; Fri, 22 Jun 2001 22:39:52 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:11530 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S265599AbRFWCjm>; Fri, 22 Jun 2001 22:39:42 -0400
Message-Id: <200106230238.f5N2cNU82518@aslan.scsiguy.com>
To: "J . A . Magallon" <jamagallon@able.es>
cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Cleanup kbuild for aic7xxx 
In-Reply-To: Your message of "Sat, 23 Jun 2001 03:20:47 +0200."
             <20010623032047.A14928@werewolf.able.es> 
Date: Fri, 22 Jun 2001 20:38:23 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>It is easier than that. Nobody should be rebuilding the firmware apart
>from driver mantainers.

The aic7xxx driver used to be this way.  It hid the fact that the
aic7xxx driver was completely open source and that anyone could
take the code, improve it, or build custom behavior from it.  Firmware
tweaks are often the only way to achieve certain behavior.  For
example, a real time system may want to embed certain types of
recovery behavior in the firmware to reduce recovery latencies.
The power of Linux and OpenSource systems in is that everything
is provided so you can make the system what you need, not what
was spoon fed to you.

--
Justin
