Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbVAGWeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVAGWeI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 17:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVAGWcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 17:32:48 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:30968 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S261667AbVAGWWe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 17:22:34 -0500
Message-Id: <200501072222.j07MMMHn019592@localhost.localdomain>
To: Andrew Morton <akpm@osdl.org>
cc: Lee Revell <rlrevell@joe-job.com>, arjanv@redhat.com, hch@infradead.org,
       mingo@elte.hu, chrisw@osdl.org, alan@lxorguk.ukuu.org.uk, joq@io.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM 
In-reply-to: Your message of "Fri, 07 Jan 2005 13:49:41 PST."
             <20050107134941.11cecbfc.akpm@osdl.org> 
Date: Fri, 07 Jan 2005 17:22:22 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.197.185.179] at Fri, 7 Jan 2005 16:22:24 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Last I checked they could be controlled separately in that module.  It
>> has been suggested (by me and others) that one possible solution would
>> be to expand it to be generic for all caps.
>
>Maybe this is the way?

that would make a much more complex LSM, and thus opens the doors to
some inadvertent security hazard that doesn't arise in the simpler
tool we have now. 

other than that, its not a terrible suggestion at all, just a lot, lot
more work.

--p


