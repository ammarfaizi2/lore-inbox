Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273567AbRIQTkA>; Mon, 17 Sep 2001 15:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273663AbRIQTjv>; Mon, 17 Sep 2001 15:39:51 -0400
Received: from mail.missioncriticallinux.com ([208.51.139.18]:6670 "EHLO
	missioncriticallinux.com") by vger.kernel.org with ESMTP
	id <S273567AbRIQTje>; Mon, 17 Sep 2001 15:39:34 -0400
Message-ID: <3BA6517F.B0E18888@MissionCriticalLinux.com>
Date: Mon, 17 Sep 2001 12:39:43 -0700
From: Bruce Blinn <blinn@MissionCriticalLinux.com>
Organization: Mission Critical Linux
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.6-bcb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Masoud Sharbiani <masu@cr213096-a.rchrd1.on.wave.home.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Reading Windows CD on Linux 2.4.6
In-Reply-To: <3BA26542.21DC105A@MissionCriticalLinux.com> <3BA29CC2.8030008@phobos.sharif.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Masoud Sharbiani wrote:
> 
> Hi,
> Can you generate a cdrom image which has that problem (and less than 50
> megs) in order
> to test?
> thanks,
> Masoud

Hi Masoud:

I created a new CD that only contains linux-2.4.6.tar.gz (23Mb), and
this CD duplicates my problem.  On 2.2.19, I can copy the tar file from
the CD, and it is the same as the original, but when using 2.4.6, I get
an IO error.

However, when I tried to copy the CD image to a file, I get the
following IO error regardless of which kernel I use.

	# dd if=/dev/cdrom of=/tmp/cd.iso
	dd: /dev/cdrom: Input/output error
	1440+0 records in
	1440+0 records out 

Does this shed any more light on what I am doing wrong.  Is there
another way for me to create a CD image for you?
	
Thanks,
Bruce
-- 
Bruce Blinn                               408-615-9100
Mission Critical Linux, Inc.              blinn@MissionCriticalLinux.com
www.MissionCriticalLinux.com

The beatings will stop when morale improves.
