Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132130AbRAXPpI>; Wed, 24 Jan 2001 10:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132698AbRAXPo6>; Wed, 24 Jan 2001 10:44:58 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:46089 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S132130AbRAXPor>;
	Wed, 24 Jan 2001 10:44:47 -0500
Message-ID: <3A6EF86B.32F6DC1E@mandrakesoft.com>
Date: Wed, 24 Jan 2001 10:44:43 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Holmberg <robert.holmberg@helsinki.fi>
CC: linux-kernel@vger.kernel.org
Subject: Re: nividia fb 0.9.0?
In-Reply-To: <20010124174558.A6608@chefren>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Holmberg wrote:
> 
> I saw version 0.9.0 of the nvidia fb driver floating around on the nvidia
> for linux mailing list some time ago. I tried it and liked it, it was A LOT
> faster and seemingly bug-free. I decided to wait for it to get integrated
> into the kernel. Time has gone by, the linux-nvidia archives are down and
> no-one seems to have submitted this patch, despite the fact that there was
> some talk about who should do it on the linux-nvidia-list. Has anyone tried
> to submit this? Otherwise I have it right here, not in patch format, but as
> a tar file including all files in the riva directory.
> 
> fbdev.c lists changes by Jindrich Makovicka:  accel code help, hw cursor,
> mtrr support.
> 
> There was a minor bugfix patch to this one as well, I think it's applied to
> my version since the version number is 0.9.0jm2, but I can't recall for
> sure.
> 
> I don't know if I could make a correct patch, since one filename
> seems to have changed from nv_local.h to nv4ref.h, and the official
> kernel version has some changes made after ths version was released
> (in November I think).
> 
> I'm putting the file up here in case someone wants to make a patch out of
> it and submit it to Linus:

I just mentioned this to Bakonyi Ferenc <fero@drama.obuda.kando.hu>, who
said that it would be better to roll a new patch without the v4l stuff,
and update rivafb.  rivafb is apparently stable but the v4l code is not
(yet).

-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
