Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129903AbRAJUUp>; Wed, 10 Jan 2001 15:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129595AbRAJUU0>; Wed, 10 Jan 2001 15:20:26 -0500
Received: from cmn2.cmn.net ([206.168.145.10]:5910 "EHLO cmn2.cmn.net")
	by vger.kernel.org with ESMTP id <S129431AbRAJUTx>;
	Wed, 10 Jan 2001 15:19:53 -0500
Message-ID: <3A5CB055.7010809@valinux.com>
Date: Wed, 10 Jan 2001 11:56:21 -0700
From: Jeff Hartmann <jhartmann@valinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.12-20smp i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: Charles McLachlan <cim20@mrao.cam.ac.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem with 2.4.0 agpgart on Dell D4100 (probably) Intel i815
In-Reply-To: <Pine.SOL.4.30.0101101409211.8321-100000@mraosd.ra.phy.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Charles McLachlan wrote:

> (The ultimate cause of what I'm about to tell you may well be a chipset
> problem, but I think I've uncovered a tiny bit of kernel weirdness none
> the less)
<snip>

>
> Does anyone have any idea what is going on?
> 
> Charlie - Queens' College - Cavendish Astrophysics - 07866 636318
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

Don't compile in I810/I815 Graphics support into the kernel.  Just 
compile the Intel 440LX/BX/GX/815/840/850 support.  That should make 
everything work fine.

-Jeff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
