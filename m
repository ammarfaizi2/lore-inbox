Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267097AbTBQRhI>; Mon, 17 Feb 2003 12:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267208AbTBQRhI>; Mon, 17 Feb 2003 12:37:08 -0500
Received: from franka.aracnet.com ([216.99.193.44]:13212 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267097AbTBQRhH>; Mon, 17 Feb 2003 12:37:07 -0500
Date: Mon, 17 Feb 2003 09:46:51 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
cc: David Woodhouse <dwmw2@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       James Bourne <jbourne@mtroyal.ab.ca>
Subject: Re: ext3 clings to you like flypaper
Message-ID: <9850000.1045504008@[10.10.2.4]>
In-Reply-To: <20030217170851.GA18693@wohnheim.fh-wedel.de>
References: <78320000.1045465489@[10.10.2.4]> <1045482621.29000.40.camel@passion.cambridge.redhat.com> <2460000.1045500532@[10.10.2.4]> <20030217170851.GA18693@wohnheim.fh-wedel.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The point remains, if I say I want ext2, I should get ext2, not whatever 
>> some random developer decides he thinks I should have. Worst of all,
>> the system then lies to you and says it's mounted ext2 when it's not.
> 
> This is, how things worked for me:
> 1. Kernel tries to mount rootfs ext3. If this fails, it will continue
> trying ext2. No other fs compiled into kernel.
> 2. If there is a journal, it is ext3.
> 3. Init scripts read /etc/fstab and read ext2.
> 4. root is remounted as ext2.
> 5. System allows me to log it, root is ext2, life is good.
> 
> Where is your behaviour different from this list? Where do you say you
> want ext2 but don't get it?

That's what I'd expect to happen ... as others have pointed out, it may
be a distro issue ... do you have the snippet of the init scrips that
do the remount as ext2 to hand? Maybe debian is just broken ...

Thanks,

M.
