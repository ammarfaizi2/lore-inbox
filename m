Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291123AbSBHAJH>; Thu, 7 Feb 2002 19:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291155AbSBHAI5>; Thu, 7 Feb 2002 19:08:57 -0500
Received: from rgminet2.oracle.com ([148.87.122.31]:4569 "EHLO
	rgminet2.oracle.com") by vger.kernel.org with ESMTP
	id <S291123AbSBHAIq>; Thu, 7 Feb 2002 19:08:46 -0500
Message-ID: <3C631758.12A329A5@oracle.com>
Date: Fri, 08 Feb 2002 01:10:00 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.4-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Patrick Mochel <mochel@osdl.org>
CC: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.4-pre1 (decoded) oops on boot in device_create_file
In-Reply-To: <Pine.LNX.4.33.0202071426170.25114-100000@segfault.osdlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:
> 
> On 7 Feb 2002, Peter Osterlund wrote:
> 
> > Alessandro Suardi <alessandro.suardi@oracle.com> writes:
> >
> > > Must be my time of the year - first the kmem_cache_create one in
> > >  2.5.3-pre[45], now this one (should happen about PCI allocation
> > >  of one of the Xircom CardBus resources):
> >
> > I had the same problem with 2.5.4-pre2. The patch below makes my
> > laptop able to boot again, but I don't know if the patch is correct.
> 
> That looks ok, since cardbus behaves internally much like PCI.
> 
> I'll check if there's anything else that needs to happen.

In the meantime I can confirm Peter's fix makes my laptop boot again :)

> Btw, thanks - I missed the original email in the sea of all the rest ;)

Uhm - well I could have directly addressed you as owner of the area
 changes, so my fault.


Thanks,
 
--alessandro

 "If your heart is a flame burning brightly
   you'll have light and you'll never be cold
  And soon you will know that you just grow / You're not growing old"
                              (Husker Du, "Flexible Flyer")
