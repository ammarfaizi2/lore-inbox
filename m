Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318340AbSGRVXk>; Thu, 18 Jul 2002 17:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318355AbSGRVXk>; Thu, 18 Jul 2002 17:23:40 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:41922 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP
	id <S318340AbSGRVXj>; Thu, 18 Jul 2002 17:23:39 -0400
Date: Thu, 18 Jul 2002 23:02:59 +0200
To: linux-kernel@vger.kernel.org, kaos@ocs.com.au
Subject: Generic modules documentation is outdated
Message-ID: <20020718210259.GJ19580@bylbo.nowhere.earth>
References: <20020704212240.GB659@bylbo.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020704212240.GB659@bylbo.nowhere.earth>
User-Agent: Mutt/1.4i
From: Yann Dirson <ydirson@altern.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have posted an oops report some time ago, and did not get any feedback.
It comes to my mind that this could be caused by the "tainted" state of my
kernel - for which I can see no valid reason.  My investigations seem to
show a number of problems:

- I have installed no proprietary driver, all loaded drivers declare to be
"GPL" or "Dual BSD/GPL".  I dicovered that I could "echo 0 >
/proc/sys/kernel/tainted"

 => is this reasonable ?

- I can't see in my logs any mention of the kernel becoming tainted (I
remember that on another machine, loading the e1000 driver triggered a
warning message - here I have no clue)

 => isn't there a mechanism that triggers a kernel log when "tainted" is set ?  
    Any reason for not having one ?

- In 2.4.18 I can't find any information about the modules licencing issues
in Documentation/modules.txt (nor in Documentation/kmod.txt, but I don't
feel this one would be the place for this, correct me if I'm wrong)

- Documentation/modules.txt still documents KERNELD, which AFAIK is not
supported any more in 2.4 kernels (and possibly since 2.2 IIRC).

 => does anyone who knows have the time to update this ?
 
-- 
Yann Dirson    <ydirson@altern.org> |    Why make M$-Bill richer & richer ?
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
Pro:    <yann.dirson@fr.alcove.com> |  Freedom, Power, Stability, Gratuity
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
