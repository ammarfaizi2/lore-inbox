Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317478AbSGXSoz>; Wed, 24 Jul 2002 14:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317474AbSGXSoz>; Wed, 24 Jul 2002 14:44:55 -0400
Received: from server1.mvpsoft.com ([64.105.236.213]:51390 "HELO
	server1.mvpsoft.com") by vger.kernel.org with SMTP
	id <S317478AbSGXSox>; Wed, 24 Jul 2002 14:44:53 -0400
Message-ID: <3D3EF5BD.5070901@mvpsoft.com>
Date: Wed, 24 Jul 2002 14:45:17 -0400
From: Chris Snyder <csnyder@mvpsoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020713
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: morten.helgesen@nextframe.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Problems with Mylex DAC960P RAID controller
References: <3D3ED215.3080900@mvpsoft.com> <20020724205019.A2356@sexything>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Morten Helgesen wrote:

> DAC960P ? I`ve got a box running 2.4.18 with a Mylex DAC960PTL1 card. The
> box is rock solid. If my memory isn`t hosed, the correct name 
> of the card is 'Mylex AccelRaid 250'.

The card BIOS says it's a DAC960P - that's all the info I've got.

> The DAC960 driver is quite verbose - this is what I`ve got :
> 
> kernel: DAC960: ***** DAC960 RAID Driver Version 2.4.11 of 11 October 2001 *****
> kernel: DAC960: Copyright 1998-2001 by Leonard N. Zubkoff <lnz@dandelion.com>

That's all the info it prints, then it hangs.  It seems to be that 
something's happening when it tries to detect the controller.

> Never had problems with the DAC960 driver in 2.4 (or 2.2 for that matter) ...
> Could you provide the message printed by your kernel ? We can continue from
> there ... maybe Leonard has an idea of what`s going on ... Leonard ?

There really aren't any messages printed by the kernel, other than the 
DAC960 version and copyright info, since it completely hangs.  I'm 
booting from a distro (Gentoo) installation CD, so no syslog facility is 
in place.

