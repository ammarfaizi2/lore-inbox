Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbUAOPhO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 10:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbUAOPhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 10:37:14 -0500
Received: from scrat.hensema.net ([62.212.82.150]:46503 "EHLO
	scrat.hensema.net") by vger.kernel.org with ESMTP id S262360AbUAOPhN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 10:37:13 -0500
From: Erik Hensema <erik@hensema.net>
Subject: Re: True story: "gconfig" removed root folder...
Date: Thu, 15 Jan 2004 15:37:09 +0000 (UTC)
Message-ID: <slrnc0dct5.2o5.erik@bender.home.hensema.net>
References: <1074177405.3131.10.camel@oebilgen> <Pine.LNX.4.58.0401151558590.27223@serv> <87ptdl2q7l.fsf@asmodeus.mcnaught.org>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.7.4 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug McNaught (doug@mcnaught.org) wrote:
> Roman Zippel <zippel@linux-m68k.org> writes:
> 
>> On Thu, 15 Jan 2004, Ozan Eren Bilgen wrote:
>>
>>> Today I downloaded 2.6.1 kernel and tried to configure it with "make
>>> gconfig". After all changes I selected "Save As" and clicked "/root"
>>> folder to save in. Then I clicked "OK", without giving a file name. I
>>> expected that it opens root folder and lists contents. But this magic
>>> configurator removed (rm -Rf) my root folder and created a file named
>>> "root". It was a terrible experience!..
>>
>> I only did a quick check with menuconfig. Are you sure it's really
>> removed? It should still be there as "/root.old".
>> I probably should change the behaviour of the save routine to behave
>> differently for directories as argument, but it doesn't remove it.
>> (Changing gconfig to only accept files in the save request would probably
>> be nice too...)
> 
> The real lesson here is "don't compile your kernel as root".  There's
> no need to do so.

Yes, having your user homedirectory removed is *much* better :-)

-- 
Erik Hensema <erik@hensema.net>
