Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277092AbRJQT3g>; Wed, 17 Oct 2001 15:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277094AbRJQT3Q>; Wed, 17 Oct 2001 15:29:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:34432 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S277083AbRJQT3I>;
	Wed, 17 Oct 2001 15:29:08 -0400
Date: Wed, 17 Oct 2001 12:29:29 -0700 (PDT)
Message-Id: <20011017.122929.63130945.davem@redhat.com>
To: cary_dickens2@hp.com
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, erik_habbinga@hp.com
Subject: Re: Problem with 2.4.14prex and qlogicfc
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <C5C45572D968D411A1B500D0B74FF4A80418D573@xfc01.fc.hp.com>
In-Reply-To: <C5C45572D968D411A1B500D0B74FF4A80418D573@xfc01.fc.hp.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "DICKENS,CARY (HP-Loveland,ex2)" <cary_dickens2@hp.com>
   Date: Wed, 17 Oct 2001 15:16:03 -0400
   
   I've done that and the problem is still there.  It no longer gives me the
   perpetual link is up message when trying to mount storage on the fibre
   channel disks.  Now it just stops.  I booted without any of the fibre
   storage being mounted and ran an fdisk on the storage in question.  The
   response from the ps -eo cmd,wchan is:
   fdisk /dev/sdc lock_page

Ok, and to reiterate this is on an x86 system with HIGHMEM enabled?
Also, just to confirm, you have _not_ applied Jen's block highmem
patches on top of this 2.4.13-preX tree right?  It is just a vanilla
2.4.13-preX tree?

Franks a lot,
David S. Miller
davem@redhat.com
