Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264406AbTEJSjb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 14:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264428AbTEJSjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 14:39:31 -0400
Received: from amsfep16-int.chello.nl ([213.46.243.26]:37400 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S264406AbTEJSja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 14:39:30 -0400
From: Jos Hulzink <josh@stack.nl>
To: Jamie Lokier <jamie@shareable.org>
Subject: Re: [PATCH] Use correct x86 reboot vector
Date: Sat, 10 May 2003 22:55:57 +0200
User-Agent: KMail/1.5
Cc: Andi Kleen <ak@muc.de>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
References: <20030510025634.GA31713@averell> <200305102141.57860.josh@stack.nl> <20030510181056.GB29682@mail.jlokier.co.uk>
In-Reply-To: <20030510181056.GB29682@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305102255.57862.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 May 2003 20:10, Jamie Lokier wrote:
> Jos Hulzink wrote:
> > For the sake of bad behaving BIOSes however, I'd vote for the f000:fff0
> > vector, unless someone can hand me a paper that says it is wrong.
>
> I agree, for the simple reason that it is what the chip does on a
> hardware reset signal.

Hmzz... this seems indeed true for the 386, that's the only doc I got at hands 
here. Willing to believe that this is the hardware behaviour of all 386 and 
newer 32 bit procs. 

If this really fixes some issues, I'm eager to see that BIOS code....

Jos
