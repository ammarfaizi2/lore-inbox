Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbVKOCtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbVKOCtK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 21:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbVKOCtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 21:49:10 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:8171 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932293AbVKOCtJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 21:49:09 -0500
Date: Tue, 15 Nov 2005 02:48:54 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Andrew Morton <akpm@osdl.org>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, linux-kernel@vger.kernel.org,
       hugh@veritas.com
Subject: Re: 2.6.14 X spinning in the kernel
In-Reply-To: <20051114173037.286db0d4.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0511150247160.24064@skynet>
References: <1132012281.24066.36.camel@localhost.localdomain>
 <20051114161704.5b918e67.akpm@osdl.org> <1132015952.24066.45.camel@localhost.localdomain>
 <20051114173037.286db0d4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> ah-hah.  We've had machines stuck in radeon_do_wait_for_idle() before.  In
> fact, my workstation was doing it a year or two back.
>
> Are you able to identify the most recent kernel which didn't do this?
>
> David, is there a common cause for this?  ISTR that it's a semi-FAQ.

Yes invariably the GPU has crashed and isn't responding to anything.
unfortuantely radeons have a lot of reasons for crashing most of them very
unrelated to anything like reality...  we normally try and approach them
on a case by case basis as some can be solved easily some not so...

Also what X was doing etc at the time is invalulable info..

Dave.


-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

