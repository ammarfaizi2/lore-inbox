Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129778AbQLHPR1>; Fri, 8 Dec 2000 10:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129415AbQLHPRR>; Fri, 8 Dec 2000 10:17:17 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:59405 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129414AbQLHPRL>;
	Fri, 8 Dec 2000 10:17:11 -0500
Message-ID: <3A30F449.32C852A3@mandrakesoft.com>
Date: Fri, 08 Dec 2000 09:46:33 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Samuelson <peter@cadcamlab.org>
CC: "Jeff V. Merkey" <jmerkey@timpanogas.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NTFS repair tools
In-Reply-To: <3A30552D.A6BE248C@timpanogas.org>
		<20001207221347.R6567@cadcamlab.org>
		<3A3066EC.3B657570@timpanogas.org>
		<20001208005337.A26577@alcove.wittsend.com>
		<20001207230407.S6567@cadcamlab.org>
		<3A306CE4.47B366B0@timpanogas.org> <14896.31327.179696.632616@wire.cadcamlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson wrote:
> 
> [Jeff Merkey]
> > Please consider the attached patch to make it a little bit harder for
> > folks to enable NTFS Write Support under Linux until it can get fixed
> > properly.
> 
> Hey!  It was a joke!  A better way would be just to comment out the
> CONFIG_NTFS_RW line entirely.  Actually, I think that *would* be a good
> idea.  Anyone who has any business messing with NTFS_RW is more than
> capable of editing Config.in.

Agreed.  I would prefer that filesystems with known broken write support
depend on CONFIG_BROKEN (which would be always defined to 'n')

	Jeff


-- 
Jeff Garzik         |
Building 1024       | These are not the J's you're lookin' for.
MandrakeSoft        | It's an old Jedi mind trick.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
