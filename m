Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268708AbUIXMQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268708AbUIXMQv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 08:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268709AbUIXMQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 08:16:50 -0400
Received: from port-212-202-157-208.static.qsc.de ([212.202.157.208]:47776
	"EHLO zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S268708AbUIXMQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 08:16:36 -0400
Message-ID: <41541009.9080206@ppp0.net>
Date: Fri, 24 Sep 2004 14:16:09 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
CC: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Hotplug List <pcihpd-discuss@lists.sourceforge.net>
Subject: Re: Is there a user space pci rescan method?
References: <E8F8DBCB0468204E856114A2CD20741F2C13E2@mail.local.ActualitySystems.com> <200409241241.19654@bilbo.math.uni-mannheim.de> <4154083B.6040109@ppp0.net> <200409241412.45204@bilbo.math.uni-mannheim.de>
In-Reply-To: <200409241412.45204@bilbo.math.uni-mannheim.de>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rolf Eike Beer wrote:
> Normally you will just remove and bring back one or two cards in the system 
> (e.g. your NIC or sound card, depending on xmms or irc being on top of your 
> priority list *g*). So from my point of view it's a good idea to keep the 
> slot dirs on remove so you can just go back in your command history and 
> replace 0 with 1 to get the device back. I don't see why bus structure or 
> whatever may ever change so rescanning the whole bus is IMHO a bit overkill.

My point was, I load dummyphp with showunused=0 and only get dirs for the
slots with devices in them. Now I decide to put a network card (or whatever
I have to spare) in an empty slot, hope that the system doesn't reboot
immediately, and voila I don't have any /sys/bus/pci/slots dir to enable
the slot and have to reboot nevertheless. Or does the pci system a rescan
if I reinsert the module?

Thanks,

Jan
