Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270412AbRHHIV7>; Wed, 8 Aug 2001 04:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270413AbRHHIVs>; Wed, 8 Aug 2001 04:21:48 -0400
Received: from t2.redhat.com ([199.183.24.243]:18674 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S270412AbRHHIVc>; Wed, 8 Aug 2001 04:21:32 -0400
Message-ID: <3B70F693.C6F7A9F@redhat.com>
Date: Wed, 08 Aug 2001 09:21:39 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-0.9smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Fang Han <dfbb@linux.net.cn>, linux-kernel@vger.kernel.org
Subject: Re: [Bug]No ATARAID chip, But ATARAID loaded
In-Reply-To: <20010808154653.B1355@dfbbb.cn.mvd>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fang Han wrote:
> 
> I use 2.4.5-ac19 ( RedHat rawhide kernel 2.4.5-5 )
> When I install it on an Machine with :
> 
> Dual PIII 700 + TYAN motherboard  512M ( No IDE RAID chips !)
> 70G IBM IDE HD connect to normal IDE
> 2 channel Adaptec 7895 ( No Scsi disk connected )
> 1 Adaptec 2940 ( No Scsi disk connected )
> Mylex DAC960 Raid with 3x38G Scsi disk (Raid5)
> 
> from booting message the Promise Software raid 0.02/ HPT370 Software 0.01
>  ) driver loaded.  And it can see the partitions of 70G IDE HD,
> All partition know as  ataraid1 ataraid5...
>  But when mounting the root filesystem(in hda1) it complain IO
> error, Then kernl panic.

Can you possibly tell if the Promise or the HPT driver detects your disk
as raid ?
That would help a lot in tracking this down.
