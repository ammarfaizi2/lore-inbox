Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317354AbSFLWxb>; Wed, 12 Jun 2002 18:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317361AbSFLWxa>; Wed, 12 Jun 2002 18:53:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45828 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317354AbSFLWx1>;
	Wed, 12 Jun 2002 18:53:27 -0400
Message-ID: <3D07D022.5030106@mandrakesoft.com>
Date: Wed, 12 Jun 2002 18:50:10 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Re : ANN: Linux 2.2 driver compatibility toolkit
In-Reply-To: <20020610174050.A21783@bougret.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes wrote:
> Jeff Garzik wrote :
> 
>>Don't load your drivers up with 2.2.x compatibility junk.  Write a 2.4.x 
>>driver... and use this toolkit to make it work under 2.2.
> 
> 
> 	Actually, wouldn't it be better to have people writting 2.5.X
> driver and having your toolkit enabling them for 2.4.X and 2.2.X ?

Sure, that would be fine too.

The main user demand has been for 2.4.x drivers on 2.2.x.  If there is 
demand for 2.0.x driver support or, what you describe, 2.5.x driver 
support on 2.[24].x, that's a good direction to head towards.  I haven't 
seen any requests for that from driver authors yet.

> 	Also, have you looked at the Pcmcia package, David Hinds has a
> pretty complete compatibility toolkit going back to 1.2.X, and used by
> many Pcmcia drivers (it's actually pretty amazing to see all those
> Pcmcia drivers working regardless). Maybe you could propose David a
> merge of the two (you get some more code and some more userbase).
> 	Yes, of course, NIH...


I am sadly guilty of "NIH" in several cases, but actually this is not 
one of them :)  I think that kcompat24 provides a bit more of a complete 
compatibility package than the other solutions.  So, I would like to 
borrow code from pcmcia and other sources to make this toolkit even 
better.  (patches accepted! :))

	Jeff


