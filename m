Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131476AbRAKSgl>; Thu, 11 Jan 2001 13:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132517AbRAKSgh>; Thu, 11 Jan 2001 13:36:37 -0500
Received: from hermes.mixx.net ([212.84.196.2]:1289 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S131476AbRAKSgS>;
	Thu, 11 Jan 2001 13:36:18 -0500
Message-ID: <3A5DFC64.2969D25E@innominate.de>
Date: Thu, 11 Jan 2001 19:33:08 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>,
        linux-kernel@vger.kernel.org
Subject: Re: Strange umount problem in latest 2.4.0 kernels
In-Reply-To: <3A5DF9CC.2F614F2A@Hell.WH8.TU-Dresden.De>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Udo A. Steinberg" wrote:
> Upon fscking after reboot, I always have errors on a
> single inode and it's always the same one:
> 
> /dev/hdb1: Inode 522901, i_blocks is 64, should be 8. FIXED
> 
> Can someone tell me an easy and reliable way of figuring
> out which file (program) uses said inode? I think that's
> probably the key to figuring out why the partition is
> busy on umount.

ls -iR | grep 12345

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
