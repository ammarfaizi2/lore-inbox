Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131724AbRC0Xgo>; Tue, 27 Mar 2001 18:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131718AbRC0Xgd>; Tue, 27 Mar 2001 18:36:33 -0500
Received: from 28-ZARA-X6.libre.retevision.es ([62.82.230.28]:13582 "EHLO
	head.redvip.net") by vger.kernel.org with ESMTP id <S131708AbRC0XgO>;
	Tue, 27 Mar 2001 18:36:14 -0500
Message-ID: <3AC12355.6070207@zaralinux.com>
Date: Wed, 28 Mar 2001 01:33:41 +0200
From: Jorge Nerin <comandante@zaralinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-ac24 i586; en-US; 0.8) Gecko/20010226
X-Accept-Language: es-es, en
MIME-Version: 1.0
To: Guest section DW <dwguest@win.tue.nl>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Win keys not working in console (2.4.x)
In-Reply-To: <3AC1072E.4080005@zaralinux.com> <20010328011148.A8265@win.tue.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guest section DW wrote:

> On Tue, Mar 27, 2001 at 11:33:34PM +0200, Jorge Nerin wrote:
> 
> 
>> Hello, good work with 2.4.x, but I miss one thing. in early 2.3.x the MS 
>> keys, you know, two flags and one "properties" key worked as navigation 
>> keys in the console.
>> 
>> The flags get you to the "left" or "rigth" virtual console, and the 
>> "properties" key put you on the last console you where before.
>> 
>> This was very useful when working in the console, I use the console 
>> sometimes, and I miss these feature.
> 
> 
> (i) Find out what key codes these keys generate.
> Vaguely I seem to recall that I made these keys produce 125, 126, 127.
> (the test command is "showkey")
> 
> (ii) Use loadkeys to assign functions to keys.
> For example,
> % loadkeys
> keycode 125 = Incr_Console
> keycode 126 = Decr_Console
> keycode 127 = Last_Console
> ^D
> should give you the desired behaviour.
> Perhaps you lost some settings during an upgrade.
> 
> See loadkeys(1) and keytables(5).

Oh, thanks, as you say I should have lost it in an upgrade, don't know 
how. I thougth it was a kernel issue, sorry. :(

Thanks.

-- 
Jorge Nerin
<comandante@zaralinux.com>

