Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129419AbRCAAjr>; Wed, 28 Feb 2001 19:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129399AbRB1X7K>; Wed, 28 Feb 2001 18:59:10 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:18705 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S129389AbRB1X6z>;
	Wed, 28 Feb 2001 18:58:55 -0500
Date: Wed, 28 Feb 2001 16:59:42 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <morton@nortelnetworks.com>, ebuddington@wesleyan.edu,
        linux-kernel@vger.kernel.org
Subject: Re: time drift and fb comsole activity
Message-ID: <20010228165942.M28471@ftsoj.fsmlabs.com>
In-Reply-To: <20010228165026.K28471@ftsoj.fsmlabs.com> <E14YGWo-0006nP-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E14YGWo-0006nP-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Mar 01, 2001 at 12:01:01AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

} > We have the same trouble on PPC but we make sure to re-sync on each
} > interrupt.  We can see several lost timer interrupts after a ^L in emacs
} > running on the fb console.  The resync lets us catch up on those interrupts
} > (and not lose time) but we still spend a lot of time not servicing
} > interrupts.
} > Does x86 not resync on timer interrupts?
} 
} The fbdev console problem is too horrible to pretend to solve by resyncing
} on timer interrupts. At least for the x86 the fix is to sort out the fb
} locking properly

How close is that?
