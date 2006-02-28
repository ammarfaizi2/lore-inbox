Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbWCGQ5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWCGQ5s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 11:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWCGQ5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 11:57:47 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:14681 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751142AbWCGQ5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 11:57:45 -0500
Message-ID: <4404BAD6.3060009@tmr.com>
Date: Tue, 28 Feb 2006 16:04:22 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Mark Lord <liml@rtr.ca>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de
Subject: Re: LibPATA code issues / 2.6.15.4
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com> <4403CEA9.4080603@rtr.ca> <44042863.2050703@dgreaves.com> <44046013.7070503@rtr.ca>
In-Reply-To: <44046013.7070503@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> David Greaves wrote:
>>
>> /dev/sda:
   [...snip...]
> ..
> hdparm-6.4 says:

Is there a version of that which will build on x86? I grabbed the 
version offered at freshmeat, but it won't compile on any x86 distro or 
gcc version to which I have access. RH8, RH9, FC1, FC3, FC4, ubuntu... 
with or without using the suggested alternate header.
> 
>         Model Number:       Maxtor 6B200M0
>         Serial Number:      B4038RRH
>         Firmware Revision:  BANC1980
> 
> Commands/features:
>         Enabled Supported:
>            *    NOP cmd
>            *    READ BUFFER cmd
>            *    WRITE BUFFER cmd
>            *    Look-ahead
>            *    Write cache
>            *    Power Management feature set
>            *    SMART feature set
>            *    FLUSH_CACHE_EXT
>            *    Mandatory FLUSH_CACHE
>            *    Device Configuration Overlay feature set
>            *    48-bit Address feature set
>                 SET_MAX security extension
>                 Advanced Power Management feature set
>            *    DOWNLOAD_MICROCODE
>            *    WRITE_{DMA|MULTIPLE}_FUA_EXT
>            *    SMART self-test
>            *    SMART error logging
> 
> So, yes, the drive is either lying about "* WRITE_{DMA|MULTIPLE}_FUA_EXT",
> or it didn't like the parameters it was given, or the SATA/IDE controller
> chip didn't like the command.

