Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285867AbRLHHok>; Sat, 8 Dec 2001 02:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285868AbRLHHoc>; Sat, 8 Dec 2001 02:44:32 -0500
Received: from nlaknet.slt.lk ([203.115.0.2]:53494 "EHLO laknet.slt.lk")
	by vger.kernel.org with ESMTP id <S285867AbRLHHoZ>;
	Sat, 8 Dec 2001 02:44:25 -0500
Message-ID: <3C126E6E.2633D01F@sltnet.lk>
Date: Sat, 08 Dec 2001 13:47:58 -0600
From: Ishan Oshadi Jayawardena <ioshadi@sltnet.lk>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14-lightening i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gerald Britton <gbritton@mit.edu>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: IDE-DMA woes
In-Reply-To: <3C115106.BED6616D@sltnet.lk> <20011207113110.A3673@light-brigade.mit.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerald Britton wrote:
> 
> reliably reproduce the problem.  I told Andre about the problem and he
> suggested doing a "hdparm -d0 -X08 /dev/hda" prior to suspend and that
> seems to work around the problem.  I "hdparm -d1 -X69 /dev/hda" on resume
> to get it back to speedy udma5 mode.  I think the problem is the BIOS doing
> things to the IDE chipset during the suspend, and the driver not properly
> correcting the changes on resume.
> 
>                                 -- Gerald

	Right. Thanks. I'll try it (hdparm -X66 actually, my drive only
supports udma2). (I know that it will work. I just want to know what's
_exactly_ wrong with my setup ;)

	-ioj
.
