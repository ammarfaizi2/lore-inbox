Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286343AbSBYUm4>; Mon, 25 Feb 2002 15:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289606AbSBYUmr>; Mon, 25 Feb 2002 15:42:47 -0500
Received: from unthought.net ([212.97.129.24]:189 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S286343AbSBYUmc>;
	Mon, 25 Feb 2002 15:42:32 -0500
Date: Mon, 25 Feb 2002 21:42:30 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Manohar Pradhan <mpml@isp.primuseurope.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re[2]: Urgent SCSI I/O Error
Message-ID: <20020225214230.C28035@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Manohar Pradhan <mpml@isp.primuseurope.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <194779754037.20020225190953@isp.primuseurope.com> <20020225210239.H24109@unthought.net> <197784956397.20020225203635@isp.primuseurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <197784956397.20020225203635@isp.primuseurope.com>; from mpml@isp.primuseurope.com on Mon, Feb 25, 2002 at 08:36:35PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2002 at 08:36:35PM +0000, Manohar Pradhan wrote:
> Hello Jakob,
> 
> Thanks. I got another HDD read. but How can I install it, format and
> make partition as earlier ( I have partition info though ..) and mount
> it? Do I need to compile the Kernel or I can attach new HDD, and start
> to create file systems inside.

Just plug in the new disk, boot the system, fdisk, create filesystems, 
copy data / restore data,  and that's it.

You only need to compile a kernel if you are plugging in some hardware
that is not supported by your running kernel.  Given that you run a
standard RedHat kernel, it should have support for just about everything
(and a kitchen sink).

You may find sfdisk useful for creating the partition tables (man sfdisk),
or you can create them "manually" using fdisk.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
