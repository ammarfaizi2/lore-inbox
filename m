Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133095AbRD3T7z>; Mon, 30 Apr 2001 15:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135841AbRD3T7o>; Mon, 30 Apr 2001 15:59:44 -0400
Received: from cs.columbia.edu ([128.59.16.20]:48025 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S133095AbRD3T72>;
	Mon, 30 Apr 2001 15:59:28 -0400
Date: Mon, 30 Apr 2001 12:59:25 -0700 (PDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.19 locks up on SMP
In-Reply-To: <E14uJnE-0000Di-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0104301255020.12259-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Apr 2001, Alan Cox wrote:

> > I also have reports but related to the network driver updates. So I
> > suggest to try again with 2.2.19 but with the drivers/net/* of 2.2.18.
> 
> Thats probably a better starting point. Its easier to back out than the VM
> changes and it would also explain the reports I saw.

Except that the only driver I'm using is eepro100, and the only change to 
that driver was the patch I submitted myself and which is also in 2.4.

Also, another data point: those two SMP boxes have been running 2.2.18 + 
Andrea's VM-global patch since January, without a hitch.

Ok, so onto the binary search through the 2.2.19pre series...

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

