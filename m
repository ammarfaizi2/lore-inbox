Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263596AbTCUMDW>; Fri, 21 Mar 2003 07:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263597AbTCUMDW>; Fri, 21 Mar 2003 07:03:22 -0500
Received: from smtp-out.comcast.net ([24.153.64.109]:15895 "EHLO
	smtp.comcast.net") by vger.kernel.org with ESMTP id <S263596AbTCUMDV>;
	Fri, 21 Mar 2003 07:03:21 -0500
Date: Fri, 21 Mar 2003 07:14:17 -0500
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
Subject: Re: 2.5.65 jaz drive devfs oops
In-reply-to: <20030321090510.A28886@infradead.org>
To: Kernel List <linux-kernel@vger.kernel.org>
Reply-to: Matthew Harrell 
	  <mharrell-dated-1048680858.8a93b4@bittwiddlers.com>
Message-id: <20030321121417.GA31412@bittwiddlers.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.3i
X-Delivery-Agent: TMDA/0.68 (Shut Out)
X-Primary-Address: mharrell@bittwiddlers.com
References: <20030319191450.GA23769@bittwiddlers.com>
 <20030319193431.A28725@infradead.org> <20030319214522.GA7397@bittwiddlers.com>
 <20030319235752.GA18086@bittwiddlers.com>
 <20030321025300.GA13772@bittwiddlers.com> <20030321090510.A28886@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

: > And, even with "devfs=nomount" on the boot line and no devfs used I still
: > get the same error once the jaz drive totally cycles down.  
: 
: Is the OOPS with devfs=nomount exactly the same?  If no or you're
: unsure please post it, too.

Yep, it's always mounted the same but the other thing I just remembered is 
that it's set up to use the automounter every time I go into /mnt/jaz.  So,
if I permenantly mount the jaz drive somewhere and just have /mnt/jaz be 
a intra-system link then it does work.  I guess this means it's a problem
with the jaz drive spinning down and "detaching" itself from the scsi bus?

I decided I would try it that way for the moment since I could then keep 
devfs on the system.  No oops but I'm sure if I unmounted it for about an
hour and then tried to mount it again it would oops

-- 
  Matthew Harrell                          Every morning is the dawn of a
  Bit Twiddlers, Inc.                       new error.
  mharrell@bittwiddlers.com     
