Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129815AbQK2HzE>; Wed, 29 Nov 2000 02:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130119AbQK2Hyn>; Wed, 29 Nov 2000 02:54:43 -0500
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:46976 "EHLO
        smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
        id <S129815AbQK2Hyg>; Wed, 29 Nov 2000 02:54:36 -0500
Message-ID: <3A24AF0D.BA913F40@haque.net>
Date: Wed, 29 Nov 2000 02:23:57 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ion Badulescu <ionut@cs.columbia.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: ext2 filesystem corruptions back from dead? 2.4.0-test11
In-Reply-To: <Pine.LNX.4.21.0011282316490.29520-100000@age.cs.columbia.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whoops, my bad. Yes, 4k blocks.

Block size:               4096


Ion Badulescu wrote:
> 
> No, you misunderstood me. df is always going to say 1k-blocks, but that
> doesn't mean that the filesystem's allocation unit is actually 1k.
> 
> Try doing a tune2fs -l on the device holding the filesystem and grep for
> "Block size". Although... looking at the numbers above, it's almost
> certainly 4k.
> 
> That's what I thought... thanks.
> 

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
