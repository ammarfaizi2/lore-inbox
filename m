Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267198AbTBLPXL>; Wed, 12 Feb 2003 10:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267209AbTBLPXK>; Wed, 12 Feb 2003 10:23:10 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:42411 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S267198AbTBLPXI>; Wed, 12 Feb 2003 10:23:08 -0500
Message-ID: <3E4A6917.2030307@nortelnetworks.com>
Date: Wed, 12 Feb 2003 10:32:39 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: David Schwartz <davids@webmaster.com>
Cc: brand@jupiter.cs.uni-dortmund.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Monta Vista software license terms
References: <20030211221137.AAA18793@shell.webmaster.com@whenever>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote the following with regards to whether a company can 
restrict distribution of modified GPL'd code through an NDA:

> 	Nobody signs the GPL. So the only way you can determine whether or 
> not someone is bound by the GPL is if they did something that they 
> could not have obtained the right to do other than by the GPL.

Okay, good so far.

> 	You don't need to assent to the GPL to receive GPL'd works. You 
> don't need to assent to the GPL to distribute rights to use a GPL'd 
> work (because everyone is already given that right).

Again true.  Everyone has the right to use a GPL'd work, so nobody has 
to *distribute* that right.

> 	So what did you do that you couldn't do without the GPL? The answer 
> is that you distributed a derived work to people who already had the 
> right to possess the original work. I am saying that that is not an 
> *additional* right to the *original* work. It's the simple sum of 
> other rights. So you don't need to assent to the GPL to get it.

The problem that I see here is that the distributor is shipping the 
modified work as a whole.

If someone were to distribute a proprietary patch to a GPL'd piece of 
software along with instructions on how to apply it, then that patch and 
those instructions could be covered under an NDA.  However, as soon as 
they distribute binaries compiled from patched code, then they are 
liable under the GPL because they are distributing work derived from a 
GPL'd work.  The GPL tries to address this in section 2, but I don't 
think that it actually has the power to restrict the distribution of 
modifications (ie patches) as long as the derived work is not 
distributed since all I'm doing is giving you instructions on what 
changes to make to something that you have the right to modify.

In the case of linux, I could have a private patch and keep it secret 
and ship it to customers under NDA with instructions on how to apply it. 
  As long as I do not ship it with the linux source or ship precompiled 
linux binaries then the GPL does not apply.  It would be a pretty 
disgusting thing to do, but I think it would be technically legal.

> 	As an example, suppose you and I both have some greeting card 
> program. I produce a greeting card that includes some graphics 
> included with the greeting card program. That greeting card is a 
> derived work. I can't distribute it to anyone I want because it 
> contains embedded graphics and I would be distributing those graphics 
> to people who had no right to them.

Usually those programs do give you the right to redistribute works 
created using the program, so your example is somewhat spurious.

> 	Again, the right to possess and use a derivative work when you 
> already have the right to possess and use the original work and the 
> right to make the derivative work is not an *additional* right to the 
> *original* work. I can't say it any clearer than that, and I welcome 
> any citations to law or court precedent to the contrary.

That statement seems to be true as far as it goes.  However, having the 
right to posess and use the original work, and the right to make a 
derivative work does *not* give you the right to distribute the derived 
work.  For that you fall under the GPL.  As I said earlier however, you 
certainly have the right to distribute modifications under any license 
you want, *as long as you do not distribute the modified work itself*. 
As soon as you distribute the derived work, you fall under the GPL. 
This means that the ultimate end-user would have to be the one applying 
the patches and compiling the derived work.

Like I said earlier, this would totally bypass the purpose of the GPL 
and I would be repulsed by a company that did this.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

