Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267226AbSKPGEV>; Sat, 16 Nov 2002 01:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267227AbSKPGEV>; Sat, 16 Nov 2002 01:04:21 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12298 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267226AbSKPGEU>;
	Sat, 16 Nov 2002 01:04:20 -0500
Message-ID: <3DD5E165.20402@pobox.com>
Date: Sat, 16 Nov 2002 01:10:45 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Finnegan <pat@purdueriots.com>
CC: Dan Kegel <dank@kegel.com>, john slee <indigoid@higherplane.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why can't Johnny compile?
References: <Pine.LNX.4.44.0211160059540.16668-100000@ibm-ps850.purdueriots.com>
In-Reply-To: <Pine.LNX.4.44.0211160059540.16668-100000@ibm-ps850.purdueriots.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Finnegan wrote:

> Wouldn't it then seem reasonable to remove things from the kernel that
> have been broken for a long time, and no one seems to care enough to fix?
> I know of at least one driver (IOmega Buz v4l) that seems to have fallen
> into disrepair possibly since before 2.4.0, and as far as I know has not
> been repaired since then.



That's really a matter of taste... a lot of Linux hackers seem to enjoy 
retrocomputing and keeping old things around just in case.  Just in case 
somebody sees you post, for example, and gets motivated to fix IOmega 
Buz :)  Some things do get removed though, every now and then.

We have CONFIG_OBSOLETE as a pseudo-config option around which we may 
deprecate drivers.  If a major version or two passes with no one 
complaining, we can remove the driver then...

	Jeff



