Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130576AbQKCQKA>; Fri, 3 Nov 2000 11:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130620AbQKCQJv>; Fri, 3 Nov 2000 11:09:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64524 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S130576AbQKCQJe>;
	Fri, 3 Nov 2000 11:09:34 -0500
Date: Fri, 3 Nov 2000 16:09:18 +0000
From: Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>
To: tytso@mit.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10)
Message-ID: <20001103160918.X2272@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <200011031509.eA3F9V719729@trampoline.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200011031509.eA3F9V719729@trampoline.thunk.org>; from tytso@mit.edu on Fri, Nov 03, 2000 at 10:09:31AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 3. Security
> 
>      * Fix module remove race bug (still to be done: TTY, ldisc, I2C,
>        video_device - Al Viro) (Rogier Wolff will handle ATM)

TBD: sysctl, kernel_thread

* drivers/input/mousedev.c dereferences userspace pointers directly.  We
should make this fail for a bit to catch those bugs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
