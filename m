Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317311AbSFGSCC>; Fri, 7 Jun 2002 14:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317312AbSFGSCB>; Fri, 7 Jun 2002 14:02:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22534 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317311AbSFGSCA>;
	Fri, 7 Jun 2002 14:02:00 -0400
Message-ID: <3D00F47C.3000801@mandrakesoft.com>
Date: Fri, 07 Jun 2002 13:59:24 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lightweight patch manager <patch@luckynet.dynu.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Mikael Pettersson <mikpe@csd.uu.se>
Subject: Re: [PATCH][2.5] tulip: change device names
In-Reply-To: <Pine.LNX.4.44.0206071140080.17181-100000@hawkeye.luckynet.adm>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the effort, that was a quick turnaround :)

But unfortunately the patch is wrong.

You need to use an index which counts _tulip_ boards, which implies that 
the index is local to the driver.  Currently the only such counter is 
board_idx, which is a variable local to tulip_init_one().

I wonder who the heck this patch is from??  Mikael?  The "Lightweight 
patch manager" seems neat, but a rather unfriendly person to reply to :)

Regards,

    Jeff


P.S. A ChangeLog entry (in the patch, or to be cut-n-pasted) is missing 
also.


