Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266330AbTAPLIA>; Thu, 16 Jan 2003 06:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266367AbTAPLH7>; Thu, 16 Jan 2003 06:07:59 -0500
Received: from [66.70.28.20] ([66.70.28.20]:17421 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S266330AbTAPLH7>; Thu, 16 Jan 2003 06:07:59 -0500
Date: Thu, 16 Jan 2003 11:32:58 +0100
From: DervishD <raul@pleyades.net>
To: Jon Burgess <Jon_Burgess@eur.3com.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Changing argv[0] under Linux.
Message-ID: <20030116103258.GA87@DervishD>
References: <80256CB0.00381BB6.00@notesmta.eur.3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <80256CB0.00381BB6.00@notesmta.eur.3com.com>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Jon :)

> exec("/proc/self/exe", ...)

    That's good, but I would like to avoid to mount procfs: what if
the mount point '/proc' doesn't exist? If you create it, you must
mount root rw and remount ro again, not a very good idea if it
haven't been fscked yet, for example. You can mount under /tmp, if it
exists at all, but that simply displaces the problem. What if
/proc/self/exe is not part form procfs, but from some evil user ;))

    Thanks a lot for your answer :)

    Raúl
