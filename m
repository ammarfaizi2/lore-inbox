Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313183AbSEVNDA>; Wed, 22 May 2002 09:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313201AbSEVNC7>; Wed, 22 May 2002 09:02:59 -0400
Received: from newnetman.ebone.net ([195.158.227.238]:29824 "EHLO
	newnetman.ebone.net") by vger.kernel.org with ESMTP
	id <S313183AbSEVNC6>; Wed, 22 May 2002 09:02:58 -0400
Message-ID: <3CEB9702.BAF27699@maersk-moller.net>
Date: Wed, 22 May 2002 15:02:58 +0200
From: Peter Maersk-Moller <Peter@maersk-moller.net>
Organization: <http://www.maersk-moller.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.5.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: i2c-old.h missing in 2.5.15-2.5.16
In-Reply-To: <E17AVty-0001am-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan.

Thanks for your email. 
Alan Cox wrote:
> > Noticed that while trying to compile 2.5.15 and 2.5.16, then some of the drivers
> > (forgot which - maybe i2c-something it self) requires existence of linux/i2c-old.h,
> > but linux/i2c-old.h seems to have been excluded. Adding linux/i2c-old.h enables
> > a succesfull compiling of the kernel, but maybe it was left out intentionally.
> 
> i2c-old has been scheduled for removal for two years and has now gone. Port
> the drivers using it to the newer i2c code. Its not too tricky. Compare the
> 2.2 and current saa5249.c for a worked example

Turned out that I didn't have the right hardware after all and since I'm
busy trying to integrate OSS codecs to replace patented MPEG-4 codecs
for streaming and since I understood from an email from Albert Cranford
that he's looking into it, I'll trust him to do a better job than I
probably can.

--PMM
