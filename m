Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130645AbRAJQQm>; Wed, 10 Jan 2001 11:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131096AbRAJQQc>; Wed, 10 Jan 2001 11:16:32 -0500
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:13767 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S130645AbRAJQQO>; Wed, 10 Jan 2001 11:16:14 -0500
Date: Wed, 10 Jan 2001 18:15:16 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1-pre1 breaks XFree 4.0.2 and "w"
Message-ID: <20010110181516.X10035@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <3A5C6417.6670FCB7@Hell.WH8.TU-Dresden.De>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A5C6417.6670FCB7@Hell.WH8.TU-Dresden.De>; from sorisor@Hell.WH8.TU-Dresden.De on Wed, Jan 10, 2001 at 02:31:03PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2001 at 02:31:03PM +0100, Udo A. Steinberg wrote:
> As I just found out, Linux 2.4.1-pre1 breaks several things on
> my system that worked perfectly in 2.4.0-final and the entire
> 2.4.0-ac tree.
> 
> XFree 4.2.0 now fails to detect monitor timings and therefore
> removes all modelines and bails out. The relevant diff of the
> X logfile follows. Note the "nan" bits.
> 
[logs]
> Since the 2.4.1-pre1 patch is rather small, it shouldn't be too hard
> to hunt down the part that causes these oddities.

The only thing that looks responsible for this is the FXSR stuff,
that changed.

Like to try again backing this out?

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
