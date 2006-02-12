Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWBLS3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWBLS3B (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 13:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWBLS3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 13:29:01 -0500
Received: from smtpout.mac.com ([17.250.248.89]:24570 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750748AbWBLS3A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 13:29:00 -0500
In-Reply-To: <200602121656.k1CGurd7019092@turing-police.cc.vt.edu>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602101337.22078.rjw@sisk.pl> <20060210233507.GC1952@elf.ucw.cz> <200602111136.56325.merka@highsphere.net> <B5780C33-81CE-4B8A-9583-B9B3973FCC11@mac.com> <43EEF711.2010409@gmail.com> <43833C9D-40A2-42B3-83D9-3C9D3EB7C434@mac.com> <43EF24C0.2040902@gmail.com> <47B33C16-AEC3-4036-BA05-AE235014684E@mac.com> <200602121656.k1CGurd7019092@turing-police.cc.vt.edu>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <451E960D-8FA5-474E-8C72-B8F834D03AF7@mac.com>
Cc: Alon Bar-Lev <alon.barlev@gmail.com>, Jan Merka <merka@highsphere.net>,
       Pavel Machek <pavel@ucw.cz>, suspend2-devel@lists.suspend2.net,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Flames over -- Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Sun, 12 Feb 2006 13:28:46 -0500
To: Valdis.Kletnieks@vt.edu
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 12, 2006, at 11:56, Valdis.Kletnieks@vt.edu wrote:
> On Sun, 12 Feb 2006 11:32:44 EST, Kyle Moffett said:
>> and X when sleeping?  Don't you *dare* say "somebody could attach  
>> a hardware debugger and read your data out of RAM", because I just  
>> don't see that happening in any reasonable situation, there are  
>> too many obstacles to doing that with a _laptop_, the first of  
>> which is just that it's impossible to take the damn thing apart  
>> when it's on without disconnecting massive amounts of critical  
>> wiring.
>
> No need to take anything apart if that laptop has a FireWire port  
> on the outside. See Quinn's Firestarter that won best hack at  
> MacHack 2002.
>
> http://www.quinn.echidna.id.au/Quinn/WWW/Hacks.html#FireStarter
>
> No need to crack the case at all. And it isn't a Mac-only issue -  
> it's the way FireWire works.

/me reads spec. *sigh*  Whatever idiocy-committee wrote that spec was  
clearly either smoking crack or living in a fantasy-world (or both).   
An arbitrary unrestricted DMA bus is a massive and painfully obvious  
security hole.  Can somebody _please_ shoot the guy that came up with  
that brilliant idea?  At least it looks like it's not available if  
the firewire modules aren't loaded, which means that you can prevent  
that sort of attack, and my laptop luckily doesn't load those modules  
at boot just to save a bit of memory.  Even still, that's just a  
terrible idea.  Is there any practical way to restrict DMA and make  
FireWire secure?

Cheers,
Kyle Moffett

--
I didn't say it would work as a defense, just that they can spin that  
out for years in court if it came to it.
   -- Rob Landley



