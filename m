Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279818AbRJ0OB4>; Sat, 27 Oct 2001 10:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279820AbRJ0OBq>; Sat, 27 Oct 2001 10:01:46 -0400
Received: from B5aee.pppool.de ([213.7.90.238]:42510 "HELO Nicole.fhm.edu")
	by vger.kernel.org with SMTP id <S279818AbRJ0OBl>;
	Sat, 27 Oct 2001 10:01:41 -0400
Date: Sat, 27 Oct 2001 15:37:48 +0200 (CEST)
From: degger@fhm.edu
Reply-To: degger@fhm.edu
Subject: Re: [PATCH] make pcmcia use correct parent resources
To: paulus@samba.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15308.53916.81722.466476@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <20011027135037.3495D72FF@Nicole.fhm.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Oct, Paul Mackerras wrote:

> I put a similar patch up some time ago and there was some discussion
> but no conclusion was reached.  This patch is almost identical except
> that I have changed the request_io/mem_resource functions that I add
> to take a pci_dev * instead of the socket_info_t * that I had before.
 
> Comments, anyone?  Linus, would you be willing to apply this to your
> tree?

I just tried a kernel with this patch but still have the same troubles
on insertion of a Cisco Aironet 340 card in my Ti PowerBook. 

This is what I get in the kernel message log:
cs: unable to map card memory!
cs: unable to map card memory!

I believe this worked at the point when I got this notebook but didn't
have the AirPort card builtin so maybe this is the culprit;
unfortunately I'm not in the mood to disassemble the notebook again
to verify that.

Ideas?

--
Servus,
       Daniel

