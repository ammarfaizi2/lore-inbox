Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWBRWA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWBRWA0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 17:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWBRWAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 17:00:25 -0500
Received: from smtp3.nextra.sk ([195.168.1.142]:54794 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S932223AbWBRWAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 17:00:25 -0500
Message-ID: <43F798EE.1070207@rainbow-software.org>
Date: Sat, 18 Feb 2006 23:00:14 +0100
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Martin Mares <mj@ucw.cz>
CC: Bill Davidsen <davidsen@tmr.com>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>, nix@esperi.org.uk,
       linux-kernel@vger.kernel.org, greg@kroah.com, axboe@suse.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <878xt3rfjc.fsf@amaterasu.srvr.nix> <43ED005F.5060804@tmr.com> <20060210235654.GA22512@kroah.com> <43F0891E.nailKUSCGC52G@burner> <871wy6sy7y.fsf@hades.wkstn.nix> <43F1BE96.nailMY212M61V@burner> <87d5hpr2ct.fsf@hades.wkstn.nix> <43F46B91.nail20W817IPJ@burner> <mj+md-20060216.123601.20797.atrey@ucw.cz> <43F746B8.6080607@tmr.com> <mj+md-20060218.210213.17059.albireo@ucw.cz>
In-Reply-To: <mj+md-20060218.210213.17059.albireo@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares wrote:
> Hello!
> 
>> MO, WORM, {ZIP,ls120} drives if you are using the full capabilities, IDE 
>> tape drives, etc.
>>
>> Sorry, I don't remember what capability the ls120 was using, but as of 
>> 2.6.12 it didn't work through the ide-floppy interface.
> 
> Then it's a bug in ide-floppy which should be fixed.
> 
I fixed something in ide-floppy some time ago - when I bought LS-120 
drive and software eject did not work. See http://lkml.org/lkml/2005/9/4/83

-- 
Ondrej Zary
