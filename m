Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271385AbTGQLns (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 07:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271386AbTGQLns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 07:43:48 -0400
Received: from [65.244.37.61] ([65.244.37.61]:15315 "EHLO
	WSPNYCON1IPC.corp.root.ipc.com") by vger.kernel.org with ESMTP
	id S271385AbTGQLmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 07:42:52 -0400
Message-ID: <170EBA504C3AD511A3FE00508BB89A920234CD4A@exnanycmbx4.ipc.com>
From: "Downing, Thomas" <Thomas.Downing@ipc.com>
To: "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: RE: 2.6.0-test1-mm1
Date: Thu, 17 Jul 2003 07:57:38 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Andrew Morton [mailto:akpm@osdl.org]
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/
> 2.6.0-test1/2.6.0-test1-mm1/
> 
> . Lots of bugfixes.
> 
> . A big one-liner from Mark Haverkamp fixes some hanges which 
> were being
>   seen with the aacraid driver and may fix the problem which 
> people have seen
>   on other SCSI drivers: everything getting stuck in 
> io_schedule() under load.
> 
> . Another interactivity patch from Con.  Feedback is needed on this
>   please - we cannot make much progress on this fairly subjective work
>   without lots of people telling us how it is working for them.

I have been testing 2.5.75-mm1.  I was able to cause video skip in xine,
but not audio.  I will repeat the tests using test1-mm1.  Anyone else
seen the video-only type skip?  It appears to be caused by other GUI
operations, not so much by CPU load.  Just dragging windows is not enough,
it needs to be more intensive than that.

More results later with test1-mm1

Thanks for all the great stuff!!

td
