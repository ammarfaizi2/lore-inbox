Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVBGUMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVBGUMf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 15:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVBGUKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 15:10:42 -0500
Received: from slartibartfast.pa.net ([66.59.111.182]:47304 "EHLO
	slartibartfast.pa.net") by vger.kernel.org with ESMTP
	id S261296AbVBGUIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 15:08:34 -0500
Date: Mon, 7 Feb 2005 15:08:24 -0500 (EST)
From: William Stearns <wstearns@pobox.com>
X-X-Sender: wstearns@sparrow
Reply-To: William Stearns <wstearns@pobox.com>
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ML-uml-user <user-mode-linux-user@lists.sourceforge.net>,
       William Stearns <wstearns@pobox.com>
Subject: Re: Linux Virtual Network Device
In-Reply-To: <4207C6E6.3080602@tiscali.de>
Message-ID: <Pine.LNX.4.61.0502071504390.6565@sparrow>
References: <4207C6E6.3080602@tiscali.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon, Matthias-Christian,
 	(This isn't a linux kernel development issue; please do further 
discussion on the uml-user mailing list only.)

On Mon, 7 Feb 2005, Matthias-Christian Ott wrote:

> I have the following the problem:
> I have server which is connected to the internet via a gateway, on this 
> server I want to run some uml machines. I want "equip" every uml machine with 
> virtual network device (virX [e.g.; the name doesn't matter]). The virtual 
> devices should be something like the "lo" device and their ip addresses 
> shouldn't be used by the internet (I'm looking for something like 127.0.0.1). 
> I want to give each uml machine a host name (e.g. xxx.myserver.mydomain.com), 
> requests should be masqueraded (by bind or dnsmasq?) by their dns name 
> (1.myserver.mydomain.com is 127.0.0.2 [vir0]). How to do this?
>
> Links or Tutorials are welcome (I just found some outdated stuff on the uml 
> website)

 	Please give these a try as a start.

http://www.stearns.org/slartibartfast/uml-coop.current.html#networking
http://www.stearns.org/slartibartfast/rc.uml-net

 	Cheers,
 	- Bill

---------------------------------------------------------------------------
 	"Power concedes nothing without a demand. It never did, and it
never will.  Find out just what people will submit to, and you have
found out the exact amount of injustice and wrong which will be imposed
upon them; and these will continue until they are resisted with either
words or blows, or with both.  The limits of tyrants are prescribed by
the endurance of those whom they oppress."
 	-- Frederick Douglass, August 4, 1857
(Courtesy of Eric S. Raymond)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------
