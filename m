Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263977AbSLaRMm>; Tue, 31 Dec 2002 12:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264610AbSLaRMl>; Tue, 31 Dec 2002 12:12:41 -0500
Received: from 132-11-27-206.netunlimited.net ([206.27.11.132]:54544 "EHLO
	mail.sportvision.com") by vger.kernel.org with ESMTP
	id <S263977AbSLaRMk>; Tue, 31 Dec 2002 12:12:40 -0500
Date: Tue, 31 Dec 2002 12:21:03 -0500
Message-Id: <200212311221.AA57934004@mail.sportvision.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "Roberto Peon" <robertopeon@sportvision.com>
Reply-To: <robertopeon@sportvision.com>
To: <linux-kernel@vger.kernel.org>, Felix Domke <tmbinc@elitedvb.net>
Subject: Re: Indention - why spaces?
X-Mailer: <IMail v7.12>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry to fan the flames... *sigh*

I like editors that show me tabs since I can use it as a simple ruler for which block I believe myself to be in. For example:

The >- characters show a tab. Were my tabwidth other than 2, I'd have that many more '-'s.

>-struct MetaObjectGetsMetaObjectAction: public ActionBase{
>->-~MetaObjectGetsMetaObjectAction(){}

>->-MetaObjectBase* a,*b;
>->-MetaObjectGetsMetaObjectAction(MetaObjectBase* ta, MetaObjectBase* tb){
>->->-a=ta;
>->->-b=tb;
>->-}

The '>-'s are in another color (dark grey in a black terminal) 
When I edit code that is written with only spaces I don't get this hint as to block-level.

The only way I can get this otherwise is to hack my editor (yech), or retab the source, which is evil and shouldn't be done.

I'm not proprosing any changes since I'm not an active kernel developer imho I've got no say in the matter and no right-to-say.

-Roberto Peon
robertopeon@sportvision.com


---------- Original Message ----------------------------------
From: Felix Domke <tmbinc@elitedvb.net>
Date: 	Mon, 30 Dec 2002 21:43:19 +0100

>hi,
>
>> This problem is as old as the typewriter itself.  The trouble is that 
>> a Tab character doesn't have a fixed size - some set it to 3 
>> characters wide, some to 4 some to 8, or whatever.
>>
>> The 'indent' program was written a couple of decades ago, to pretty 
>> print C code.  It has a 'GNU' standard, but I'm not aware of a 'Linux' 
>> standard.  Anyhoo, the only way to prevent indentation wars is to use 
>> spaces, not tabs and to set 'diff' to ignore white space when 
>> comparing files... 
>
>Anyhow, sorry, i really can't understand that. What could be more 
>"indention war preventing" that letting everybody use his own indention 
>width?
>
>There are two main aspects of *not* using tabs:
> - editors mess them up. but: use an *editor*. not a word processor. 
>kernel source's line endings are \n, not \r\n. some (windows) editors 
>mess them up.  and nobody cares (and that's ok that way. nobody WANTS to 
>use an editor which messes up so simple things).
>some editors don't show tabs. well. this leads to a mixup of tabs <-> 
>spaces. but if you really fear about this, just use an editor which 
>supports showing tabs. joe doesn't show spaces (by default?), but i 
>never missed that, for example.
> - aligning. well, just use spaces for aligning, tabs for indention. two 
>different things. two different characters.
>
>TAB characters simply *have* no assigned width. that's the reason for 
>them. they are not a macro for 3/4/8 spaces.
>
>not using spaces, in my eyes, just *takes* a possibility to 
>platform-independant format sourcecode on the given screensize. it gives 
>you nothing.
>
>and as they might be some pitfalls (wrong aligning etc.), you can still 
>set the tabwidth to the one of the author. in that case, you didn't win 
>anything by using tabs, but you didn't loose either.
>
>again, i was just *wondering* why everybody is using spaces, and still, 
>i can't find a good reason for that. if anybody shows me that, i'll 
>maybe start using spaces (again).
>
>felix
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
