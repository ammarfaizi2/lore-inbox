Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131666AbRDCAAL>; Mon, 2 Apr 2001 20:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131573AbRDCAAC>; Mon, 2 Apr 2001 20:00:02 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:58578 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S131586AbRDBX74>;
	Mon, 2 Apr 2001 19:59:56 -0400
Message-ID: <3AC91253.34E3C9DA@mandrakesoft.com>
Date: Mon, 02 Apr 2001 19:59:15 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-20mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Douglas Gilbert <dougg@torque.net>, Peter Daum <gator@cs.tu-berlin.de>,
   linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: scsi bus numbering
In-Reply-To: <200104022050.f32KoRs93074@aslan.scsiguy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Justin T. Gibbs" wrote:
> It is bogus that this stuff depends on link order to function
> correctly.

No, it is simply one more rule, and one that is not immediately
obvious.  Take heart though.  Like Rolaids, 2.5's updated makefile
system will bring relief...

Make sure to add a comment, when you update the 2.4 makefile where link
order is significant.  (as it is not, in all cases)

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full moon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
