Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269766AbUJSU4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269766AbUJSU4k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 16:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269406AbUJSUvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 16:51:08 -0400
Received: from c7ns3.center7.com ([216.250.142.14]:52399 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S269766AbUJSUrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 16:47:06 -0400
Message-ID: <41757478.4090402@drdos.com>
Date: Tue, 19 Oct 2004 14:09:28 -0600
From: "Jeff V. Merkey" <jmerkey@drdos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dax Kelson <dax@gurulabs.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.9 and GPL Buyout
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org>	 <417550FB.8020404@drdos.com> <1098218286.8675.82.camel@mentorng.gurulabs.com>
In-Reply-To: <1098218286.8675.82.camel@mentorng.gurulabs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dax Kelson wrote:

>>
>>JFS, XFS, All SMP support in Linux, and RCU.
>>    
>>
And Numa also.

>>    
>>
>
>This isn't SCO code. This goes back to SCO's claims of "control rights"
>over any source code that has been in the same room as UNIX code.
>
>These "control rights" depend on SCOs interpretation of what a 
>derivative work is. This is a contractual dispute, an attempt of SCO to
>reframe what a derivative work is and a big up hill battle for SCO as
>virtually all the parties of original contracts have in their
>declarations not supported SCO claims of "control rights".
>
>Stephen D. Vuksanovich, Scott Nelson, Richard A. McDonough III, Robert
>C. Swanson, Ira Kistenberg, David Frasure, and Geoffrey D. Green.
>
>Four of them are (or were at relevant time periods) AT&T employees.
>
>See: http://www.groklaw.net/article.php?story=20041007032319488
>
>Besides the declarations, there is other items that don't back SCO
>"control rights" claims such as the $echo newletter, and amendment X to
>the contract.
>
>Dax Kelson
>
>
>  
>
No.  They seem to have some factual concrete evidence IP covered under 
Employee
agreements was used and subsequently converted into Linux, and they are 
very
confident of this.  From a cursory viewpoint, it looks valid.  I think 
they have a case
(having been sued and nailed for the same type of thing by Novell).  
It's better to remove
these code areas and make the vendors maintain them as separate patches 
not in the tree,
like what happened to intermezzo.  It's low impact for Linux and the 
other vendors.

XFS, JFS and NUMA are easy ones.

RCU and NUMA are not.  Hey, Novell just handed over their patent 
portfolio to Linux,
use their patents for SMP and RCU.  These areas are not trivial to dump 
out of the kernel.
If Linux did dump the infringing FS's, it would be a good faith effort 
to limit SCO's claims.

SMP and RCU look a little tougher to defend.  I remember a Brainshare 
session at SLC
where the unixware guys were disclosing this stuff in public sessions.  
Perhaps Novell
could go back and publish those Brainshare slides on their website.  So 
much for claiming
SMP and RCU are not in the public domain.

Dump the FS's and NUMA guys.  Then you are nearly there for being 
squeaky clean.

Jeff



