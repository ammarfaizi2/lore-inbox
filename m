Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270976AbTGVRu4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 13:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270977AbTGVRu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 13:50:56 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:51486 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S270976AbTGVRuy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 13:50:54 -0400
Message-ID: <3F1D7BBF.8070202@rackable.com>
Date: Tue, 22 Jul 2003 11:00:31 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Charles Lepple <clepple@ghz.cc>, michaelm <admin@www0.org>,
       linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: Make menuconfig broken
References: <20030721163517.GA597@www0.org> <32425.216.12.38.216.1058806931.squirrel@www.ghz.cc> <3F1C8739.2030707@rackable.com> <3F1C888B.8040500@rackable.com> <Pine.LNX.4.44.0307221146120.714-100000@serv>
In-Reply-To: <Pine.LNX.4.44.0307221146120.714-100000@serv>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jul 2003 18:05:54.0609 (UTC) FILETIME=[E4C91A10:01C3507B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:

>Hi,
>
>On Mon, 21 Jul 2003, Samuel Flory wrote:
>
>  
>
>>  Try this in 2.6.0-test1:
>>rm .config
>>make mrproper
>>make menuconfig
>>
>>  There is no option for CONFIG_VT, and CONFIG_VT_CONSOLE under 
>>character devices in "make menuconfig.
>>    
>>
>
>Try enabling CONFIG_INPUT.
>
>Vojtech, how about the patch below? This way CONFIG_VT isn't hidden behind 
>CONFIG_INPUT, but CONFIG_INPUT is selected if needed.
>

  Now that's very confusing.   So in order to enable something under the 
Character devices menu you need to 1st enable something under "Input 
device support".   Which for some reason is configured as a module?  It 
says something that I resorted to editing .config by hand.


   Is it too much to ask to make the defaults give us a working 
console?  Otherwise we will be answering the question of "why does 
screen go blank after uncompressing" for the entire 2.6 cycle!!  The 
number of people who don't want to enable config_vt is fairly small, and 
they will be wanting to remove a number of our defaults any way.


-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


