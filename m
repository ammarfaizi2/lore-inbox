Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270021AbUIDBFC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270021AbUIDBFC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 21:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270020AbUIDBDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 21:03:13 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:39846 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S269985AbUIDA74 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 20:59:56 -0400
Date: Sat, 4 Sep 2004 01:59:55 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Alex Deucher <alexdeucher@gmail.com>
Cc: dri-devel@lists.sf.net, linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
In-Reply-To: <a728f9f904090317547ca21c15@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0409040158400.25475@skynet>
References: <Pine.LNX.4.58.0409040107190.18417@skynet>
 <a728f9f904090317547ca21c15@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Will this redesign allow for multiple 3d accelerated cards in the same
> machine?  could I have say an AGP radeon and a PCI radeon or a AGP
> matrox and a PCI sis and have HW accel on :0 and :1.  If not, I think
> it's something we should consider.

should be no problem at all, this is what I consider a DRM requirement so
any design that doesn't fulfill it isn't acceptable...

of course implemented code may need a bit of testing :-)

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

