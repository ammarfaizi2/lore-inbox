Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRADWNF>; Thu, 4 Jan 2001 17:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129370AbRADWMz>; Thu, 4 Jan 2001 17:12:55 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:8967 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129267AbRADWMl>;
	Thu, 4 Jan 2001 17:12:41 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200101042212.f04MCDN510138@saturn.cs.uml.edu>
Subject: Re: So, what about kwhich on RH6.2?
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 4 Jan 2001 17:12:13 -0500 (EST)
Cc: ak@suse.de (Andi Kleen), andrewm@uow.edu.au (Andrew Morton),
        zaitcev@metabyte.com (Pete Zaitcev), linux-kernel@vger.kernel.org
In-Reply-To: <E14EBZw-0005oG-00@the-village.bc.nu> from "Alan Cox" at Jan 04, 2001 02:41:17 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> can't we just hardwire `kgcc' into the build system and be done
>>> with all this kwhich stuff?  It's just a symlink....
>>
>> And break compilation on all non RedHat 7, non connectiva systems ? 
>> Would you volunteer to handle the support load on l-k that would cause?
>
> Hardcoding kgcc is definitely not an option. 

Creating symlinks during the build would solve the problem.

/usr/src/linux/kern-cc -> /usr/bin/kgcc
/usr/src/linux/user-cc -> /usr/bin/gcc
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
