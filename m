Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933054AbWFWMQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933054AbWFWMQU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 08:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933080AbWFWMQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 08:16:20 -0400
Received: from web36904.mail.mud.yahoo.com ([209.191.85.72]:59492 "HELO
	web36904.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S933054AbWFWMQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 08:16:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=J4QtkGDj1DiU0sPnwHl4JaUVQGamI+JBeN4pf7/CgsawGR5HmoY9WjaZ/YFN0oB3mnS5v04PsuiAOR4cpWDYdxWighkWj/wYW6hVuxBMMty4R7uIfciAW1qyaDFH6KFtKEjf+vRiDWuTIh9sKuYIIu+/0X0fmK7OZdHneEpViqU=  ;
Message-ID: <20060623121619.11995.qmail@web36904.mail.mud.yahoo.com>
Date: Fri, 23 Jun 2006 13:16:19 +0100 (BST)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: [i2c] [PATCH] I2C bus driver for Philips ARM boards
To: Vitaly Wool <vitalywool@gmail.com>
Cc: greg@kroah.com, i2c@lm-sensors.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20060623133855.59b08f33.vitalywool@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Vitaly Wool <vitalywool@gmail.com> wrote:

> On Thu, 22 Jun 2006 23:26:00 +0100 (BST)
> Mark Underwood <basicmark@yahoo.com> wrote:
>  
> > Would it not make sense to call this driver ip3204 or ph_ip3204 or some such seeing as you
> > correctly point out that this is a common Philips IP block and is used in other, non pnx,
> chips?
> 
> No I don't think it would -- this is an internal Philips IP block number AFAIK and was given
> there only for reference.
> Funny is that people from Philips Semi asked me about a year ago not to use internal IP block
> numbers in the code. I know you're also from Philips... Well, what does that prove? It proves
> that everything can't be in alignment in such a big company. ;-)

OK.

>  
> > I'm also not sure why the register map is in the arch-pnx4008 directory as this will require
> every
> > chip that has this IP block to have a copy of the file.
> 
> IIRC, PNX5220 has a slightly different register map. Of course the main registers are the same
> but putting first N regs into common header and putting others into arch header would have made
> even less sense.

I'm not familiar with the PNX5220. What you've done makes sense now :-). Thanks for the
explanation.

Mark


> 
> Vitaly
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



		
___________________________________________________________ 
Does your mail provider give you FREE antivirus protection? 
Get Yahoo! Mail http://uk.mail.yahoo.com
