Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129314AbQL1Gch>; Thu, 28 Dec 2000 01:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129348AbQL1Gc2>; Thu, 28 Dec 2000 01:32:28 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:20999
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S129314AbQL1GcM>; Thu, 28 Dec 2000 01:32:12 -0500
Date: Thu, 28 Dec 2000 19:01:43 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Ari Heitner <aheitner@andrew.cmu.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: innd mmap bug in 2.4.0-test12
Message-ID: <20001228190143.A14673@metastasis.f00f.org>
In-Reply-To: <20001228160005.B14479@metastasis.f00f.org> <Pine.SOL.3.96L.1001228000150.3482A-100000@unix13.andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SOL.3.96L.1001228000150.3482A-100000@unix13.andrew.cmu.edu>; from aheitner@andrew.cmu.edu on Thu, Dec 28, 2000 at 12:06:47AM -0500
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2000 at 12:06:47AM -0500, Ari Heitner wrote:

    does anyone other than me think that the pm code is *way* too
    agressive about spinning down the hard drive? my 256mb laptop
    (2.2.16) will only spin down the disk for about 30 seconds before
    it decides it's got something else it feels like writing out, and
    spins back up. Spinnup has got to be more wasteful than just
    leaving the drive spinning...

use hdparm to increase the spin-down time then


  --cw
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
