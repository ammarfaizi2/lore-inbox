Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293709AbSCKLz0>; Mon, 11 Mar 2002 06:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293711AbSCKLzQ>; Mon, 11 Mar 2002 06:55:16 -0500
Received: from [194.46.8.33] ([194.46.8.33]:42249 "EHLO angusbay.vnl.com")
	by vger.kernel.org with ESMTP id <S293709AbSCKLzL>;
	Mon, 11 Mar 2002 06:55:11 -0500
Date: Mon, 11 Mar 2002 12:06:31 +0000
From: Dale Amon <amon@vnl.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, George Bonser <george@gator.com>,
        Mark Hahn <hahn@physics.mcmaster.ca>
Cc: Dale Amon <amon@vnl.com>, linux-kernel@vger.kernel.org
Subject: Re: Pentium mobo fails on upgrade from 2.2 to 2.4
Message-ID: <20020311120631.GO3296@vnl.com>
Mail-Followup-To: Dale Amon <amon@vnl.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	George Bonser <george@gator.com>,
	Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
In-Reply-To: <20020309134540.GZ13355@vnl.com> <E16jm3j-0002Ew-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16jm3j-0002Ew-00@the-village.bc.nu>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux, the choice of a GNU generation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to all who replied and offered suggestions.
Although the suggestions themselves didn't solve
the problem, they eventually led me to it by
suggesting that the BIOS was indeed faulty.

It appears that it was turned on in my 2.2.18 kernel
and it worked fine; but when I updated with oldconfig
it brought the old settings across. I assumed that
because the feature worked in the old kernel on that
MoBo, it was okay and the board didn't have the listed
chip sets anyway.

When at wits end, I disabled it anyway, just because
it said "buggy BIOS".

That solved the problem. So I'm sorted.

Does anyone keep track of what MoBo/chipset and 
kernel major version combinations have finicky
config requirements? I'd be happy to supply whatever
info you need.

-- 
------------------------------------------------------
    Nuke bin Laden:           Dale Amon, CEO/MD
  improve the global          Islandone Society
     gene pool.               www.islandone.org
------------------------------------------------------
