Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965216AbWIFBsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965216AbWIFBsN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 21:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965255AbWIFBsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 21:48:13 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:29631 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965216AbWIFBsK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 21:48:10 -0400
Message-ID: <44FE28CB.6070005@garzik.org>
Date: Tue, 05 Sep 2006 21:47:55 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: sergio@sergiomb.no-ip.org
CC: Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, greg@kroah.com, harmon@ksu.edu,
       Daniel Drake <dsd@gentoo.org>, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] take 4 Re: VIA IRQ quirk, another (embarrassing)	suggestion.
References: <1157330567.3046.24.camel@localhost.portugal>	 <20060903175841.7a84c63c.akpm@osdl.org> <44FBBD28.6070601@garzik.org>	 <20060904055502.GA26816@tuatara.stupidest.org>	 <1157370847.4624.15.camel@localhost.localdomain>	 <20060904183352.GA14004@tuatara.stupidest.org>	 <1157468155.30252.17.camel@localhost.localdomain>	 <44FD9431.2050403@garzik.org> <1157505255.3145.32.camel@localhost.portugal>
In-Reply-To: <1157505255.3145.32.camel@localhost.portugal>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergio Monteiro Basto wrote:
> On Tue, 2006-09-05 at 11:13 -0400, Jeff Garzik wrote:
>> Sergio Monteiro Basto wrote:
>>> On Mon, 2006-09-04 at 11:33 -0700, Chris Wedgwood wrote:
>>>> On Mon, Sep 04, 2006 at 12:54:07PM +0100, Sergio Monteiro Basto wrote:
>>>>
>>>>> I don't know if this is a real question. Have we VIA products on PCI
>>>>> card, running on not VIA chip sets ?
>>>> Yes.  Certainly for on-board devices too.
>>> OK , other argument.
>>> We have billions of VIA chip sets with VIA PCI on-board and 
>>> VIA PCI on others chip sets, if exists, are a very few.
>>> So, because some exceptions, we shouldn't stop a resolution of a very
>>> large % of the cases. 
>> No thanks.  As VIA SATA maintainer, I like being able to use my VIA SATA 
>> PCI card.
>>
>> 	Jeff
> 
> I have 2 computer with 2 different Asrock
> (http://www.asrock.com/product/775Dual-880Pro.htm) boards, both have a
> VIA8237 and a VIA SATA, and both are quirked wrongly, when I use kernels
> 2.6.17+ . 
> And if I haven't bought this 2 computers in a supermarket, I won't be
> here discussion this subjects.
> 
> So I like to remember  
> http://lkml.org/lkml/2006/7/28/264
> http://lkml.org/lkml/2006/9/4/111 ( that confirm a VIA SATA on XT-PIC
> mode ) http://lkml.org/lkml/2006/9/1/106 )
> 
> So VIA SATA needs my patch or Daniel Drake patch to _WORK_ .

No argument.

I'm just saying that you cannot avoid the VIA-device-not-on-VIA-chipset 
case.  I don't care which patch is used, as long as _both_ cases work.

	Jeff



