Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbVIFLwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbVIFLwe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 07:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbVIFLwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 07:52:34 -0400
Received: from web31008.mail.mud.yahoo.com ([68.142.200.171]:28546 "HELO
	web31008.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964823AbVIFLwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 07:52:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ujLd7zUn8GonkmKVthH91ZE7edz0YgQqu9TeZ75SMd0nu7urD8AInu6Q+l7TUoRJvkcgO3hluAD/AUSb6vWRmxwFossnUs5xjzOKmyGkaaDQKsbYTPr7OsL6dQ0RIzga2IMXZ8bBGnC3Ny46qNYrY4a2xSZBsjh1l3amiuxEvaI=  ;
Message-ID: <20050906115228.80715.qmail@web31008.mail.mud.yahoo.com>
Date: Tue, 6 Sep 2005 04:52:28 -0700 (PDT)
From: Hugo Vanwoerkom <hvw59601@yahoo.com>
Subject: Re: INPUT: keyboard_tasklet - don't touch LED's of already grabed device
To: Aivils Stoss <aivils@unibanka.lv>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org
Cc: bruby <linuxconsole-dev@lists.sourceforge.net>
In-Reply-To: <200509061034.55963.aivils@unibanka.lv>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Aivils Stoss <aivils@unibanka.lv> wrote:

> Hi, Vojtech!
> 
> Recent kernels allow exclusive usage of input device
> when
> input device is grabed. keyboard_tasklet does not
> check
> device state and switch LED's of all keyboards.
> However
> grabed device may be use another LED steering code.
> 
> This patch forbid keyboard_tasklet switch LED's of
> grabed devices.
> 
> Aivils Stoss


While trying this with 2.6.12 it gets a compilation
error. Not when you move the added statements after
the structure declaration.

Is that me heading for them thar hills?

Hugo

<snip patch>



	
		
______________________________________________________
Click here to donate to the Hurricane Katrina relief effort.
http://store.yahoo.com/redcross-donate3/
