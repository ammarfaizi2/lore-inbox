Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135778AbRAMADG>; Fri, 12 Jan 2001 19:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135791AbRAMAC4>; Fri, 12 Jan 2001 19:02:56 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:48910 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S135778AbRAMACm>; Fri, 12 Jan 2001 19:02:42 -0500
Message-ID: <3A5F9B01.53B42D06@sgi.com>
Date: Fri, 12 Jan 2001 16:02:09 -0800
From: Florin Andrei <florin@sgi.com>
Organization: SGI
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18-lvs-1.0.3-reiserfs-3.5.29 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, db@cyclonehq.dnsalias.net
Subject: Re: [eepro100] Ok, I'm fed up now
In-Reply-To: <LAW2-F8403oHMwVN7mi0000e9c6@hotmail.com>
	 <LAW2-F8403oHMwVN7mi0000e9c6@hotmail.com> <5.0.2.1.0.20010112153102.021f34e8@10.0.0.254>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan B wrote:
> 
> Has anyone gotten Intel's (non-GPL) e100 driver working in 2.4.x yet?  What
> about their e100-ANS driver that supports FEC 800mbps?

	My system at home has an Intel 815 motherboard (video, sound and network are
included into the motherboard), and works quite well with 2.4.0. I was able to
use its graphics card (obviously, because it's an i815), sound (with ALSA)
and... surprise!... network card!
	You just have to use the eepro100 driver (from the mainstream 2.4.0 kernel),
and the netcard will work (i use the eepro100 driver compiled as a module). I
posted this tip few days ago to the Intel netcards newsgroup.

	Previously, with 2.2 kernels, i had to use Intel's non-GPL e100 driver,
because the eepro100 driver from 2.2 kernels didn't worked with my card.

-- 
Florin Andrei
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
