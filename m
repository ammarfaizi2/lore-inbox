Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129335AbRBLCje>; Sun, 11 Feb 2001 21:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131099AbRBLCjY>; Sun, 11 Feb 2001 21:39:24 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:59913 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129335AbRBLCjL>;
	Sun, 11 Feb 2001 21:39:11 -0500
Message-ID: <3A874CB4.717C101C@mandrakesoft.com>
Date: Sun, 11 Feb 2001 21:38:44 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christian Ullrich <chris@chrullrich.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1: Abnormal interrupt from RTL8139
In-Reply-To: <20010208093854.A1122@christian.chrullrich.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Ullrich wrote:
> I'm getting some of these messages in syslog:
> Feb  6 07:38:35 christian kernel: eth0: Abnormal interrupt, status 00000010.
> Feb  6 07:38:35 christian kernel: eth0: Abnormal interrupt, status 00000010.
> Feb  6 07:38:35 christian kernel: eth0: Abnormal interrupt, status 00000020.
> Feb  7 17:32:53 christian kernel: eth0: Abnormal interrupt, status 00000041.
[...]
> I have not observed any effects related to these messages.

Those messages are logged at the debugging level... if they bother you,
don't log kern.debug...

	Jeff



-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
