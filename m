Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129305AbRAZJKj>; Fri, 26 Jan 2001 04:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129390AbRAZJKb>; Fri, 26 Jan 2001 04:10:31 -0500
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:42501 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S129305AbRAZJKI>; Fri, 26 Jan 2001 04:10:08 -0500
Date: Fri, 26 Jan 2001 22:09:59 +1300
From: Chris Wedgwood <cw@f00f.org>
To: kuznet@ms2.inr.ac.ru
Cc: "David S. Miller" <davem@redhat.COM>, linux-kernel@vger.kernel.org
Subject: Re: [UPDATE] Zerocopy, last one today I promise :-)
Message-ID: <20010126220959.C11097@metastasis.f00f.org>
In-Reply-To: <14960.22256.322768.447815@pizda.ninka.net> <200101251940.WAA10110@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200101251940.WAA10110@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Thu, Jan 25, 2001 at 10:40:40PM +0300
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 25, 2001 at 10:40:40PM +0300, kuznet@ms2.inr.ac.ru wrote:

    It simply does not exist for 82559* in all the steppings.
    eepro100 is pretty poor device.
    
    Probably, it exists for card identified as Gamla (D102) (82559 is
    D101).

I have code from Audrey to enable HWCK for received only and code
from you for SG -- but no way to enable HWCK for TX. The Intel
provided drivers themselves don't seem to have any way of doing this
so i wonder if it is either undocumented so Intel can sell the same
hardware at a premium (as they do for NT, the only different being
drivers) or simply because the HW is poor.



  --cw
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
