Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266025AbUAKXRj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 18:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266026AbUAKXRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 18:17:38 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:54463 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S266025AbUAKXRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 18:17:37 -0500
Message-ID: <4001DB52.7030908@pacbell.net>
Date: Sun, 11 Jan 2004 15:25:06 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       USB Developers <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: USB hangs
References: <1073779636.17720.3.camel@dhcp23.swansea.linux.org.uk>	 <20040111002304.GE16484@one-eyed-alien.net> <1073788437.17793.0.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1073788437.17793.0.camel@dhcp23.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Sul, 2004-01-11 at 00:23, Matthew Dharm wrote:
> 
>>Where is USB kmalloc'ing with GFP_KERNEL?  I thought we tracked all those
>>down and eliminated them.
> 
> 
> Not sure. I just worked from tracebacks. I needed it to work rather
> than having the time to go hunting for specific faults. Plus I'd
> argue PF_MEMALLOC is a better solution anyway.

It certainly seems like a more comprehensive fix for that
particular class of problems!  :)



