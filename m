Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265473AbUAJXOd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 18:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265488AbUAJXOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 18:14:33 -0500
Received: from out011pub.verizon.net ([206.46.170.135]:60072 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S265473AbUAJXOa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 18:14:30 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None that appears to be detectable by casual observers
To: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: Q re /proc/bus/i2c
Date: Sat, 10 Jan 2004 18:14:29 -0500
User-Agent: KMail/1.5.1
Cc: John Lash <jlash@speakeasy.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200401100117.42252.gene.heskett@verizon.net> <200401101415.46745.gene.heskett@verizon.net> <1073763636.9096.18.camel@nosferatu.lan>
In-Reply-To: <1073763636.9096.18.camel@nosferatu.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401101814.29104.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [151.205.61.108] at Sat, 10 Jan 2004 17:14:28 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 January 2004 14:40, Martin Schlemmer wrote:

>> Next thing to check?
>
>What mobo (make, model, etc - sorry, missed that), and do you
>have appropriate modules loaded.  Also, maybe add a dmesg.

I sent that, but you can call off the bloodhounds, the perp has been 
apprehended and jailed.

Actually, there is a huge gotcha in make xconfig.  If, under busses 
early in the menu, you do not select ISA, even if your mobo doesn't 
have one, you MUST enable it before you can even see the i2c-isa 
options and turn them on in the i2c tree.  Bad dog, no bisquit, it 
should be shown and the help should say it needs the busses/isa 
enabled too.

Turned them both on and everything but the eeprom and temps is working 
in sensors output, minor details because the cpu temp IS being 
displayed by gkrellm just fine, as are both of the fan rpms.

Many thanks to Nuno Montiero for tickling me in the right spot with an 
email about that, to John Lash and Martin Schlemmer who were also 
helping me chase it down, and to the list for putting up with my 
whining.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty: soap,
ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

