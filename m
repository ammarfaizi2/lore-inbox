Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135509AbRAYFVl>; Thu, 25 Jan 2001 00:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135508AbRAYFVb>; Thu, 25 Jan 2001 00:21:31 -0500
Received: from [24.67.108.36] ([24.67.108.36]:2176 "EHLO
	ogah.cgma1.ab.wave.home.com") by vger.kernel.org with ESMTP
	id <S135507AbRAYFVW>; Thu, 25 Jan 2001 00:21:22 -0500
Date: Wed, 24 Jan 2001 22:19:00 -0700
From: Harold Oga <ogah@home.com>
To: linux-kernel@vger.kernel.org
Subject: Re: nividia fb 0.9.0?
Message-ID: <20010124221900.A721@ogah.cgma1.ab.wave.home.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010124174558.A6608@chefren> <3A6EF86B.32F6DC1E@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A6EF86B.32F6DC1E@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Wed, Jan 24, 2001 at 10:44:43AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 24, 2001 at 10:44:43AM -0500, Jeff Garzik wrote:
>I just mentioned this to Bakonyi Ferenc <fero@drama.obuda.kando.hu>, who
>said that it would be better to roll a new patch without the v4l stuff,
>and update rivafb.  rivafb is apparently stable but the v4l code is not
>(yet).
Hi,
   I'm currently using Jindrich Makovicka's latest patch, and it works
very well.  It has all the rivatv 0.6 stuff rolled in, but as long as you
don't configure in all the v4l/tv-out stuff, and you just configure in
rivafb, everything works very well.  This one seems not to have some of
the minor glitches I saw with rivafb 0.9.0.  I have the patch applied on
top of 2.4.1-pre3 and didn't have any problems applying it.  The patch can
be found here:

<http://kmlinux.fjfi.cvut.cz/toASCII/~makovick/rivafb/rivatv-0.6jm2-2.4.0.diff.bz2>

-Harold
-- 
"Life sucks, deal with it!"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
