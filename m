Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317348AbSGXPkI>; Wed, 24 Jul 2002 11:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317355AbSGXPkH>; Wed, 24 Jul 2002 11:40:07 -0400
Received: from postfix2-2.free.fr ([213.228.0.140]:5540 "EHLO
	postfix2-2.free.fr") by vger.kernel.org with ESMTP
	id <S317348AbSGXPkH>; Wed, 24 Jul 2002 11:40:07 -0400
Message-Id: <200207231847.g6NIlQf17967@fuji.home.perso>
Date: Tue, 23 Jul 2002 20:47:23 +0200 (CEST)
From: fchabaud@free.fr
Reply-To: fchabaud@free.fr
Subject: Re: [PATCH][swsusp] 2.4.19-pre10-ac2
To: swsusp@lister.fornax.hu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020723075940.GD116@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 23 Jul, Pavel Machek a écrit :
> Hi!
> 
>> > No, this is incorrect. I believe rpciod could submit packet for io in
>> > time we are freezing devices. If it does that... bye bye to your data.
>> 
>> 
>> I think so. At first I did freeze those two tasks but someone post a much simpler patch and... I think you're right. I'll fix that.
>> 
> 
> Mail me a patch when you have that.

That's in beta9. Have a look at the incremental patch.

> 
>> > Fixing swap signatures should really be done in separate function.
>> > 
>> > 									Pavel
>> > PS: This is what I did in response to your patch (it compiles,
>> > otherwise untested). I'll try to fix noresume fixing signatures
>> > somehow.
>> 
>> For 2.5 tree ?
> 
> Yep. [Actually noresume fixing signatures is harder than I expected.]

Astonishing. Actually with 2.4 I found it easier than I thought.

> PS: Killed Alan from Cc, he reads lists anyway and I guess he's not
> so much interested.

OK.

--
Florent 

