Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263885AbTLORZu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 12:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263890AbTLORZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 12:25:50 -0500
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:39593 "EHLO
	ns.kalifornia.com") by vger.kernel.org with ESMTP id S263885AbTLORZf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 12:25:35 -0500
Message-ID: <3FDDEE8B.3080000@blue-labs.org>
Date: Mon, 15 Dec 2003 12:25:31 -0500
From: David Ford <david+hb@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: as@sci.fi
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4 vs 2.6
References: <fa.iaibikf.1l5injd@ifi.uio.no> <fa.m5245vp.h0ukb5@ifi.uio.no> <20031215105602.8E693B802@hylsy.jippii.fi>
In-Reply-To: <20031215105602.8E693B802@hylsy.jippii.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Partial comments below

Anssi Saari wrote:

>>  -- modules don't autoload for some reason (though I'm sure that could
>>     be solved),
>>    
>>
>
>I've had this too, with autofs4 and 3c59x. After patching lirc into the
>kernel, the only real issue is with the console. I found a patch for radeonfb,
>but didn't get anywhere with it.
>
>The rest of my problems is userland stuff:
>
>- Murasaki (a hotplug agent) doesn't react when USB things are plugged in
>  
>

You need to update your hotplug installation.  Turn on debugging in your 
hotplug scripts and copy the appropriate object ID numbers into the 
usb.usermap file.

>- swapon -a takes two minutes to complete for some reason
>  
>

Try recreating your swapon partition/file?  Turning on a gig of swap 
here happens pretty quick.

>- rpc.lockd doesn't start, it says lockdsvc: Function not implemented. I don't
>  
>

Update/rebuild your rpc/nfs tools.

>  know if I really need this anyway, nfs seems to work fine
>- zsh doesn't complete make targets like menuconfig
>- I'd also like to point out that cdrecord isn't sufficient for my 
>  CD writing needs, I need cdrdao too and it doesn't seem to support
>  direct access to ATAPI drives. 
>  
>

I haven't used zsh or cdrdao so I can't comment on them.   I don't use 
the above modules, but all the other modules on my system (numerous) do 
autoload just fine.  NFS is a big PITA for me for other reasons but the 
services do start.

My systems are of the Gentoo flavor.

David

