Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbUJaXYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbUJaXYM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 18:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbUJaXYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 18:24:11 -0500
Received: from washoe.rutgers.edu ([165.230.95.67]:30147 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S261689AbUJaXYH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 18:24:07 -0500
Date: Sun, 31 Oct 2004 18:24:05 -0500
From: Yaroslav Halchenko <yoh@psychology.rutgers.edu>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: ipod vfat
Message-ID: <20041031232405.GB31975@washoe.rutgers.edu>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20041031213523.GO1530@washoe.rutgers.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041031213523.GO1530@washoe.rutgers.edu>
X-Image-Url: http://www.onerussian.com/img/yoh.png
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sorry guys - it seems that the necessary steps were taken in the
last kernel version:

        /*
         * The low byte of FAT's first entry must have same value with
         * media-field.  But in real world, too many devices is
         * writing wrong value.  So, removed that validity check.
         *
         * if (FAT_FIRST_ENT(sb, media) != first)
         */

So I will give it a spin :-)

Sorry once again

-- 
Yarik

On Sun, Oct 31, 2004 at 04:35:23PM -0500, Yaroslav Halchenko wrote:
> Dear Kernel Developers,

> Is it possible to incorporate the next patch which I had to introduce to
> have the vfat fs of my ipod to get mounted under Linux.

> Originally its vfat was mounting ok, but then at some point which I
> didn't clearly mentioned, it stopped... probably it happened after I
> attached ipod to some windows box, because now windows still can easily
> mount it whenever vanilla linux kernel refuses...

> Or should I just adjust my ipod's fs definition?

> Thank you in advance
-- 
                                                  Yaroslav Halchenko
                  Research Assistant, Psychology Department, Rutgers
          Office  (973) 353-5440 x263  Fax (973) 353-1171
   Ph.D. Student  CS Dept. NJIT
             Key  http://www.onerussian.com/gpg-yoh.asc
 GPG fingerprint  3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8

