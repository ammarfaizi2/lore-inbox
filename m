Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbVE3LTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbVE3LTu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 07:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVE3LT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 07:19:29 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:45471 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261445AbVE3LTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 07:19:18 -0400
Date: Mon, 30 May 2005 12:19:09 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Kyle Moffett <mrmacman_g4@mac.com>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       dri-devel@lists.sourceforge.net
Subject: Re: [PATCH] DRM depends on ???
In-Reply-To: <429AF53B.3080805@aitel.hist.no>
Message-ID: <Pine.LNX.4.58.0505301216500.31258@skynet>
References: <Pine.LNX.4.62.0505282333210.5800@anakin> <20050528215005.GA5990@redhat.com>
 <1FA58BE7-0EE6-432B-9383-F489F9854DBE@mac.com> <Pine.LNX.4.58.0505290809180.9971@skynet>
 <Pine.LNX.4.62.0505292157130.12948@numbat.sonytel.be>
 <64148E06-2DFA-41A5-9D86-5F34DCAAF9F4@mac.com> <429AF53B.3080805@aitel.hist.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Why is that case invalid?  I may have DRM=y so I get DRM on my
> PCI graphichs card.  Then I might load an agp module in order
> to use agp on *some other* agp card. I have no problem with DRM=y,AGP=m being
> invalid for the common
> single-card setup, but there are multi-card setups too.  Not that
> I need this special case personally - I have two cards but don't use modules.

Yes but the support costs for me of allowing that second case aren't
worth it, if people have a special case they don't lose anything by having
AGP supported DRM in the kernel or AGP in the kernel all the time..
whereas I don't have to answer a load of questions from people whose AGP
cards stop working because they build DRM into the kernel and AGP as a
module...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

