Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129625AbQK1X0R>; Tue, 28 Nov 2000 18:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129704AbQK1X0I>; Tue, 28 Nov 2000 18:26:08 -0500
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:56804 "EHLO
        smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
        id <S129625AbQK1XZ7>; Tue, 28 Nov 2000 18:25:59 -0500
Message-ID: <3A2437F6.6380A1BF@haque.net>
Date: Tue, 28 Nov 2000 17:55:50 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Alexander Viro <viro@math.psu.edu>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tigran Aivazian <tigran@veritas.com>
Subject: Re: ext2 filesystem corruptions back from dead? 2.4.0-test11
In-Reply-To: <14877.53881.182935.597766@notabene.cse.unsw.edu.au>
                <Pine.GSO.4.21.0011240006040.12702-100000@weyl.math.psu.edu> <14881.62969.786424.812353@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I'm not sure what else to try. I've even tried throwing around 1.6
GB of data, and copying and deleting at the same time. Nothing. Again,
this is _without_ the patches sent by Alexander.

I think I'm just gonna go on to test12-pre2.

Neil Brown wrote:
> 
> Turns out my data is a false alarm.  It was a bug in my raid5 code -
> and not a recent bug either - that was causing my filesystem
> corruption.
> 
> So if your earlier patches work for everybody else then they look like
> a good way to go.  I have fixed my fatal flaw and I cannot reproduce
> the problems any more.  Patch has gone to Alan.

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
