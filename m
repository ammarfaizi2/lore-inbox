Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269949AbUJSWXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269949AbUJSWXe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 18:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269945AbUJSWUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 18:20:10 -0400
Received: from out014pub.verizon.net ([206.46.170.46]:12009 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S267365AbUJSWQM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:16:12 -0400
Message-ID: <4175922B.7020505@verizon.net>
Date: Tue, 19 Oct 2004 18:16:11 -0400
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@drdos.com>
CC: Dax Kelson <dax@gurulabs.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.9 and GPL Buyout
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org>	 <417550FB.8020404@drdos.com> <1098218286.8675.82.camel@mentorng.gurulabs.com> <41757478.4090402@drdos.com>
In-Reply-To: <41757478.4090402@drdos.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [209.158.211.53] at Tue, 19 Oct 2004 17:16:11 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey wrote:
> Dax Kelson wrote:
> 
>>>
>>> JFS, XFS, All SMP support in Linux, and RCU.
>>>   
> 
> And Numa also.
> 
>>>   
>>
>>
>> This isn't SCO code. This goes back to SCO's claims of "control rights"
>> over any source code that has been in the same room as UNIX code.
>>
>> These "control rights" depend on SCOs interpretation of what a 
>> derivative work is. This is a contractual dispute, an attempt of SCO to
>> reframe what a derivative work is and a big up hill battle for SCO as
>> virtually all the parties of original contracts have in their
>> declarations not supported SCO claims of "control rights".
>>
>> Stephen D. Vuksanovich, Scott Nelson, Richard A. McDonough III, Robert
>> C. Swanson, Ira Kistenberg, David Frasure, and Geoffrey D. Green.
>>
>> Four of them are (or were at relevant time periods) AT&T employees.
>>
>> See: http://www.groklaw.net/article.php?story=20041007032319488
>>
>> Besides the declarations, there is other items that don't back SCO
>> "control rights" claims such as the $echo newletter, and amendment X to
>> the contract.
>>
>> Dax Kelson
>>
>>
>>  
>>
> No.  They seem to have some factual concrete evidence IP covered under 
> Employee
> agreements was used and subsequently converted into Linux, and they are 
> very
> confident of this.  From a cursory viewpoint, it looks valid.  I think 
> they have a case
> (having been sued and nailed for the same type of thing by Novell).  
> It's better to remove
> these code areas and make the vendors maintain them as separate patches 
> not in the tree,
> like what happened to intermezzo.  It's low impact for Linux and the 
> other vendors.
> 
> XFS, JFS and NUMA are easy ones.
> 
> RCU and NUMA are not.  Hey, Novell just handed over their patent 
> portfolio to Linux,
> use their patents for SMP and RCU.  These areas are not trivial to dump 
> out of the kernel.
> If Linux did dump the infringing FS's, it would be a good faith effort 
> to limit SCO's claims.
> 
> SMP and RCU look a little tougher to defend.  I remember a Brainshare 
> session at SLC
> where the unixware guys were disclosing this stuff in public sessions.  
> Perhaps Novell
> could go back and publish those Brainshare slides on their website.  So 
> much for claiming
> SMP and RCU are not in the public domain.
> 
> Dump the FS's and NUMA guys.  Then you are nearly there for being 
> squeaky clean.
> 
> Jeff
> 


<troll-bite>

You know, SCO sounds like the guys I've worked with when they failed a 
drug test - "C'mon, I was at a party, I was only around the stuff, I 
never touched it, you can't fire me!"

 From http://en.wikipedia.org/wiki/SCO_v._IBM :

SCO currently claims:

     * Any code belonging to SCO that might have been GPL'd was done by 
SCO employees without proper legal authorization, and thus is not 
legally GPL'd.
     * That for code to be GPL'd, the code's copyright owner must put a 
GPL notice before the code, but since SCO itself wasn't the one to add 
the notices, the code was never GPL'd.

and:

SCO's major claims have now been reported as relating to the following 
components of the Linux kernel:

     * symmetric multiprocessing (SMP),
     * non-uniform memory access (NUMA) multiprocessing,
     * the read-copy-update (RCU) locking strategy,
     * SGI's Extended File System (XFS),
     * and IBM's JFS journaling file system

These claims flow from the accusation of breach of contract. The 
contract between IBM and AT&T (to which SCO claims to be successor in 
interest) allows IBM to use the SVR4 code, but the SVR4 code, plus any 
derivative works made from that code, must be held confidential by IBM. 
According to IBM's interpretation of the contract, and the 
interpretation published by AT&T in their "$ echo" newsletter in 1985, 
"derivative works" means any works containing SVR4 code. But according 
to SCO's interpretation, "derivative works" also includes any code built 
on top of SVR4, even if that does not contain, or even never contained, 
any SVR4 code. Thus, according to SCO, any AIX operating system code 
that IBM developed must be kept confidential, even if it contains 
nothing from SVR4.

so:

If SCO is saying that any code in the kernel that belongs to SCO was 
done by SCO employees, then why are they suing IBM?

Are they claiming that AIX was developed by SCO employees?

Or are they claiming that Linux was developed former SCO employees 
working for IBM?

</troll-bite>
