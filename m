Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317351AbSFLWus>; Wed, 12 Jun 2002 18:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317352AbSFLWur>; Wed, 12 Jun 2002 18:50:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43012 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317351AbSFLWur>;
	Wed, 12 Jun 2002 18:50:47 -0400
Message-ID: <3D07CF81.30904@mandrakesoft.com>
Date: Wed, 12 Jun 2002 18:47:29 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ion Badulescu <ionut@cs.columbia.edu>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ANN: Linux 2.2 driver compatibility toolkit
In-Reply-To: <200206111707.g5BH7qA10658@buggy.badula.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ion Badulescu wrote:
> On Mon, 10 Jun 2002 17:40:18 -0400, Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
> 
>>Don't load your drivers up with 2.2.x compatibility junk.  Write a 2.4.x 
>>driver... and use this toolkit to make it work under 2.2.
> 
> 
> Now, if you could get Alan to include it in 2.2.next, that would be even
> better. I could probably drop 90% of the cruft I have in starfire-kcomp22.h...



Absolutely....  I haven't mentioned this to Alan specifically, but it is 
indeed a direction I would like to go.  A good step would be getting 
your help to make sure that starfire works with kcompat24 (perhaps with 
minor patching)  :)  If we have tested patches ready for 2.2 that will 
go a long way towards winning Alan's acceptance, I'm sure.

Another idea I just had:  a good way to introduce kcompat24 to 2.2 is to 
use it to add a few 2.4.x-only net drivers to 2.2.  That way nothing 
changes [initially], only additions are made.

	Jeff


