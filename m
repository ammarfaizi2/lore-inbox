Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbTEZSGW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 14:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbTEZSGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 14:06:22 -0400
Received: from scaup.mail.pas.earthlink.net ([207.217.120.49]:25269 "EHLO
	scaup.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S261989AbTEZSGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 14:06:18 -0400
From: Eric <eric@cisu.net>
Reply-To: eric@cisu.net
To: linux-kernel@vger.kernel.org
Subject: Re: New make config options
Date: Mon, 26 May 2003 13:18:24 -0500
User-Agent: KMail/1.5.1
References: <200305261004.25297.eric@cisu.net> <200305261724.23712.rudmer@legolas.dynup.net>
In-Reply-To: <200305261724.23712.rudmer@legolas.dynup.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305261318.24887.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 May 2003 10:24 am, Rudmer van Dijk wrote:
> what about `make allmodconfig` ??
>
Now if we can convince someone to code it :(
I wish I could throw something together myself but I can only suggest the 
ideas.  Hopefully someone with the time/skills/interest can put something 
together to do this. I would have no problems testing the feature if someone 
else who could write it needs some help testing.

> then you have a .config with most things as module and you can always use
> `make menuconfig` to adjust it.

Great idea. Not really a button in make menuconfig, but a make allmodconfig 
and it resets everythign to modules. Then you could use the regualr make 
config facility to tune it. There would be no need to hack up make 
menuconfig.

> BTW try a `make help` to see all other make options.
Are you suggesting this as a feature? Lol, i tried make help and it there was 
no rule for it. 2.4.20 kernel.

----------------------
Eric Bambach   
Eric@CISU.net 
----------------------
