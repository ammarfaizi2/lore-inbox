Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266489AbUGUJly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266489AbUGUJly (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 05:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266490AbUGUJly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 05:41:54 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:1782 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S266489AbUGUJlh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 05:41:37 -0400
Date: Wed, 21 Jul 2004 10:41:10 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: phil.stewart@lichp.co.uk
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: Re: dri ioctl32 problem on amd64/x86_64 on 2.6.8-rc2 and earlier
In-Reply-To: <1090355841.40fd828136bd2@webmail.lichp.co.uk>
Message-ID: <Pine.LNX.4.58.0407211036400.27038@skynet>
References: <1090355841.40fd828136bd2@webmail.lichp.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I have a working direct rendering mechanism in my 64-bit userland. However,
> 32-bit software running in a 32-bit chroot environment cannot operate with the
> 64-bit drm. I get the following error when executing the 32-bit glxinfo inside
> the chroot:
>

the DRM has some major 64-bit issues that we need to break backwards
compatibility we haven't simply be able to declare a time when the people
who need to work on it can spare the amount of time needed together...

I think the plan is to fix the issues in the DRM CVS and try and push them
to Linus in one big push which breaks all platforms together and we can
have a flag day....

One remaining issue is what types to use in the headers used in both
kernel/userspace, we don't want to have two separate headers (why should
we?) so what types should we use ... surely someone has done this before..

Regards,
Dave.
[drm-maintainer]

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

