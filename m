Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264519AbUGYVrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264519AbUGYVrd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 17:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264522AbUGYVrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 17:47:33 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:23526 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S264519AbUGYVrb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 17:47:31 -0400
Date: Sun, 25 Jul 2004 23:46:41 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Ferenc Kubinszky <ferenc.kubinszky@wit.mht.bme.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: via-velocity problem
Message-ID: <20040725234641.A30025@electric-eye.fr.zoreil.com>
References: <20040725183338.A27442@electric-eye.fr.zoreil.com> <Pine.LNX.4.44.0407252146260.30105-101000@wit.wit.mht.bme.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0407252146260.30105-101000@wit.wit.mht.bme.hu>; from ferenc.kubinszky@wit.mht.bme.hu on Sun, Jul 25, 2004 at 09:51:07PM +0200
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ferenc Kubinszky <ferenc.kubinszky@wit.mht.bme.hu> :
[...]
> I use modules...

I did not made my point clear. You previously said:
[...]
> I have a via-velocity gigabit ethernet controller on my Abit KV8pro
> motherboard. I tried it with kernel 2.6.7-rc1, 2.6.7-rc2 and the
> 2.6.7-rc1-mm1 drivermodule in 2.6.7-rc2 on A Debian SID.
>
> If I load it at the command promt, it seems to be working without any
> problem. I can set up an IP address etc.

Did the 'etc' include 'and wget (or similar app) works fine' ?

[...]
> Attached.

Thanks.
Can you check if there is a backup file of the dmesg after boot
in your /var/log (or elsewhere) ? The very first lines of the dmesg
have been cut.²

> Now, the machine hangs when I try to test the module :(
> First time ping -s1000 -i0.2 worked, but after that the machine died...

A few more details could help:
- can you reproduce this misbehavior if the fglrx module is never loaded
  after boot ?
- assuming sysrq has no effect (?), are the keyboard leds dead or do they
  still answer after lockup ?
- is the driver able to send/receive more than 64 packets during a simple
  ping (no -i option) ?

--
Ueimor
