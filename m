Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284264AbSBMOOB>; Wed, 13 Feb 2002 09:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284933AbSBMONy>; Wed, 13 Feb 2002 09:13:54 -0500
Received: from barn.holstein.com ([198.134.143.193]:7436 "EHLO holstein.com")
	by vger.kernel.org with ESMTP id <S284300AbSBMONm>;
	Wed, 13 Feb 2002 09:13:42 -0500
Date: Wed, 13 Feb 2002 09:13:18 -0500
Message-Id: <200202131413.g1DEDIU20262@pcx4168.holstein.com>
From: "Todd M. Roy" <troy@holstein.com>
To: alan@redhat.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200202131317.g1DDHSQ14686@devserv.devel.redhat.com> (message
	from Alan Cox on Wed, 13 Feb 2002 08:17:28 -0500 (EST))
Subject: Re: Linux 2.4.18pre9-ac3
Reply-To: troy@holstein.com
In-Reply-To: <200202131317.g1DDHSQ14686@devserv.devel.redhat.com>
X-MIMETrack: Itemize by SMTP Server on Imail/Holstein(Release 5.0.1b|September 30, 1999) at
 02/13/2002 09:13:20 AM,
	Serialize by Router on Imail/Holstein(Release 5.0.1b|September 30, 1999) at
 02/13/2002 09:13:21 AM,
	Serialize complete at 02/13/2002 09:13:21 AM
X-Priority: 3 (Normal)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,
  I had to add
EXPORT_SYMBOL(blkdev_varyio);

to ksyms.c to get sd_mod.o to compile and load.

I encountered it in pre9-ac2 and didn't
get a chance to email you.
I'm surprised that nobody else caught it!
