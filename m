Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266130AbUALM77 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 07:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266138AbUALM77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 07:59:59 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:7755 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S266130AbUALM76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 07:59:58 -0500
Message-ID: <40029A44.4030406@samwel.tk>
Date: Mon, 12 Jan 2004 13:59:48 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dax Kelson <dax@gurulabs.com>
CC: Jan De Luyck <lkml@kcore.org>, linux-kernel@vger.kernel.org,
       Kiko Piris <kernel@pirispons.net>, Bartek Kania <mrbk@gnarf.org>,
       Simon Mackinlay <smackinlay@mail.com>
Subject: Re: [PATCH] Laptop-mode v7 for linux 2.6.1
References: <3FFFD61C.7070706@samwel.tk> <200401121045.56749.lkml@kcore.org>	 <40026FEC.4040707@samwel.tk> <1073911834.2892.0.camel@mentor.gurulabs.com>
In-Reply-To: <1073911834.2892.0.camel@mentor.gurulabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dax Kelson wrote:
>>>There seems to be a typo in the battery.sh script. It 
>>>reads /proc/acpi/ac_adapter/AC/state to determine the AC Adaptor state, but 
>>>this is in the ACAD directory instead of the AC directory.
>>
>>Hmmm, Dax says it works for him, and I don't have an ac_adapter on my 
>>machine because I don't own a laptop. Dax, is this a typo or is it 
>>actually called AC on your machine?
> 
> On my Dell Inspiron 4150 it is called AC not ACAD.

Hmmmm. Does anybody have any idea why these names differ? Googling for 
acpi/ac_adapter gives me hits on a number of different programs that 
check for ac_adapter/*/state. I've seen AC, ACAD, 0 and 1 for names, so 
they're really pretty variable. So, a wildcard seems appropriate. Dax, 
if you agree, would you test + send in a patch to correct this? I can't 
do it myself because I can't test it. TIA!

-- Bart
