Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130130AbRBZCde>; Sun, 25 Feb 2001 21:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130126AbRBZCdO>; Sun, 25 Feb 2001 21:33:14 -0500
Received: from smtp.bellnexxia.net ([209.226.175.26]:41115 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S130122AbRBZCdF>; Sun, 25 Feb 2001 21:33:05 -0500
Message-ID: <3A99C060.D56ADF28@coplanar.net>
Date: Sun, 25 Feb 2001 21:33:04 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Derrik Pates <dpates@andromeda.dsdk12.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE floppy drives and devfs - no device nodes if no disk loaded 
 atboot
In-Reply-To: <Pine.LNX.4.33.0102251733400.11946-100000@andromeda.dsdk12.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Derrik Pates wrote:

> Subject says about all there is to say. I have figured out that IDE drives
> are enumerated as part of the boot-time partition check in
> fs/partitions/check.c, but if I don't have something loaded at boot time
> (IDE SuperDisk in PC at home, IDE Zip 100 in G3 tower at work), I never
> get device nodes at all with devfs. Something really needs to be done
> about this, IMHO.

hdparm's got a cmd line switch to unregiser/register and ide interface.
It tried it *once* and it just complained about cmd line args being wrong...
i'll have to look into it more.  when working it should help your situation.

