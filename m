Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263228AbUDYTu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbUDYTu2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 15:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263246AbUDYTu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 15:50:28 -0400
Received: from 80-169-17-66.mesanetworks.net ([66.17.169.80]:6356 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S263228AbUDYTu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 15:50:26 -0400
Date: Sun, 25 Apr 2004 13:50:56 -0600
From: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: File system compression, not at the block layer
Message-ID: <20040425195056.GA449@bounceswoosh.org>
Mail-Followup-To: Willy Tarreau <willy@w.ods.org>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040424073622.GN596@alpha.home.local> <200404250305.i3P355eF003826@pincoya.inf.utfsm.cl> <20040425072918.GA21148@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20040425072918.GA21148@alpha.home.local>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25 at  9:29, Willy Tarreau wrote:
>I know, I was speaking about physical platters of course. Mark Hann told
>me in private that he disagreed with me, so I checked recent disks 
>(36, 73, 147 GB SCSI with 1, 2, 4 platters) and he was right, they have
>exactly the same spec concerning speed. But I said that I remember the
>times when I regularly did this test on disks that I was integrating about
>7-8 years ago, they were 2.1, 4.3, 6.4 GB (1,2,3 platters), and I'm fairly
>certain that the 1-platter performed at about 5 MB/s while the 6.4 was around
>12 MB/s. BTW, the 9GB SCSI I have in my PC does about 28 MB/s for 1 platter,
>while its 18 GB equivalent (2 platters) does about 51. So I think that what
>I observed remained true for such capacities, but changed on bigger disks
>because of mechanical constraints. Afterall, what's 18 GB now ? Less than
>one twentieth of the biggest disk.
>
>Anyway, this is off-topic, so that's my last post on LKML on the subject.

Let me throw in a final $.02...

Are you sure your 9GB and 18GB drives are of the same "generation" of
technology?  SCSI drive platters have gotten smaller and smaller to
shorten the seek distance (they use 2.5" media now inside 3.5" drives)
for random operations, and I'm wondering if your 18GB is in fact a
generation ahead of your 9GB.

Are you sure your 9GB SCSI drive only has 1 platter in it?

--eric

-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org

