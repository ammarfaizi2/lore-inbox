Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264455AbUAJA0g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 19:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264476AbUAJA0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 19:26:36 -0500
Received: from smtp.sys.beep.pl ([195.245.198.13]:43273 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S264455AbUAJA0f convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 19:26:35 -0500
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: Stan Bubrouski <stan@ccs.neu.edu>
Subject: Re: 2.6.1-mm1 and modular IDE.
Date: Sat, 10 Jan 2004 01:26:20 +0100
User-Agent: KMail/1.5.94
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58L.0401092345370.9003@alpha.zarz.agh.edu.pl> <1073693365.2706.15.camel@duergar>
In-Reply-To: <1073693365.2706.15.camel@duergar>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200401100126.20525.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 of January 2004 01:09, Stan Bubrouski wrote:
> On Fri, 2004-01-09 at 17:50, Wojciech 'Sas' Cieciwa wrote:
> > OK. I try to build 2.6.1 with and without -mm1 patch.
> > Both with options listed below.
> > in attachment are output logs.
> > they are identical - that means that modular IDE in 2.6.1-mm1 is broken.
>
> Correct me if I'm wrong, but wouldn't modular IDE be a bad idea anyways
> if you don't have SCSI boot drive?  Think about it, without IDE layer,
> how's it going to mount the IDE drives to get the IDE module off of one
> of them?  You'd need it compiled in, right?
Wrong. You can always use initrd and put IDE (or any else) modules there and 
that's what we do with Wojtek in PLD.

-- 
Arkadiusz Mi¶kiewicz    CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PLD/Linux
