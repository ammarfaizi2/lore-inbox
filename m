Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274729AbRIUBPH>; Thu, 20 Sep 2001 21:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274730AbRIUBO4>; Thu, 20 Sep 2001 21:14:56 -0400
Received: from sushi.toad.net ([162.33.130.105]:61058 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S274729AbRIUBOl>;
	Thu, 20 Sep 2001 21:14:41 -0400
Message-ID: <3BAA946F.2D2900AC@yahoo.co.uk>
Date: Thu, 20 Sep 2001 21:14:23 -0400
From: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Problem: PnP BIOS driver reports outdated information
In-Reply-To: <E15kDsP-0006er-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> If you query the current device status on a Vaio and some other boxes
> using the 32bit API your computer dies horribly shortly afterwards.
> 
> So yes - we should be handling setpnp in the kernel, but no we can't query
> the bios for the data

How about this: pnpbios functions that scan the device list
optionally (depending on a flag of some sort, set according to
whether or not one has an evil BIOS) cause the list to be rebuilt
first.  This would require only slight changes to the code.

I would offer a patch, but I don't know how the aforementioned
flag should be implemented.

Thomas Hood
jdthood_AT_yahoo.co.uk
