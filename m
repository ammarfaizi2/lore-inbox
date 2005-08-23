Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbVHWUUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbVHWUUY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 16:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbVHWUUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 16:20:24 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:3602 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932366AbVHWUUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 16:20:23 -0400
Date: Tue, 23 Aug 2005 22:20:18 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Davy Durham <pubaddr2@davyandbeth.com>
Cc: Willy Tarreau <willy@w.ods.org>, bert hubert <bert.hubert@netherlabs.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: select() efficiency / epoll
Message-ID: <20050823202018.GA28724@alpha.home.local>
References: <42E162B6.2000602@davyandbeth.com> <20050722212454.GB18988@outpost.ds9a.nl> <430AF11A.5000303@davyandbeth.com> <20050823182405.GA21301@outpost.ds9a.nl> <430B01FB.2070903@davyandbeth.com> <20050823191254.GB10110@alpha.home.local> <430B077A.10700@davyandbeth.com> <20050823194557.GC10110@alpha.home.local> <430B0EAE.9080504@davyandbeth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <430B0EAE.9080504@davyandbeth.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2005 at 06:55:26AM -0500, Davy Durham wrote:
> Thanks for the info.. I did find this thread and was wondering if this 
> patch ever got put in
> 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0303.3/1139.html
> 

Interesting ! At least it does not seem to be present in the
epoll-2.4.24-0.20 I have right here, and although the code changed
significantly in 2.6, it does not seem to contain it either. But I
don't even see how to merge this into 2.6. You should ask Davide,
he knows this code better than anyone else, and could tell us if
this patch was simply lost or is unneeded.

Regards,
Willy

