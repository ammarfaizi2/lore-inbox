Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264092AbVBDXTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264092AbVBDXTg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 18:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266343AbVBDW71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 17:59:27 -0500
Received: from the-penguin.otak.com ([65.37.126.18]:39127 "EHLO
	the-penguin.otak.com") by vger.kernel.org with ESMTP
	id S265896AbVBDW23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 17:28:29 -0500
Date: Fri, 4 Feb 2005 14:28:26 -0800
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, Netdev <netdev@oss.sgi.com>
Subject: Re: SysKonnect sk98lin Gigabit lan missing in action from 2.6.10 on
Message-ID: <20050204222825.GA8533@the-penguin.otak.com>
References: <42038994.20401@xmission.com> <4203E3FE.2090806@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4203E3FE.2090806@pobox.com>
X-Operating-System: Linux 2.6.11-rc3-mm1 on an i686
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik [jgarzik@pobox.com] wrote:
> maxer wrote:
> >What is the status of sk98lin? Do we have to wait until Syskonnect gets 
> >their act together
> >and write a new driver for 2.6.10?
> >
> >Their latest is Oct 2004 and not at all compatible with 2.6.10 and beyond.
> 
> I've been telling SysKonnect for _years_ that they need to split up 
> their patches, but they still keep sending ever-larger jumbo driver 
> update patches.
> 
> Stephen Hemminger split up their patch into a bunch of patches, and I 
> applied several of those.
> 
> Apparently, Stephen also got sick of trying to patch and clean sk98lin, 
> so he went and wrote his own "skge" driver.  It's available in my 
> netdev-2.6 queue, and should be in the latest -mm.
> 
> 	Jeff
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


I have a SysKonnect card, and tried the skge driver (it's in the mm tree), with nominal testing 
I'd have to say it works well, if not better then the sk98lin driver.



-- 
*--* Mail: lawrence@otak.com
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://the-penguin.otak.com/~lawrence
--------------------------------------
- - - - - - O t a k  i n c . - - - - - 


