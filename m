Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286161AbSAIM0a>; Wed, 9 Jan 2002 07:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286297AbSAIM0U>; Wed, 9 Jan 2002 07:26:20 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:13579 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S285828AbSAIM0L>; Wed, 9 Jan 2002 07:26:11 -0500
Date: Wed, 9 Jan 2002 13:26:09 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE Patch (fwd)
Message-ID: <20020109122608.GD5707@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10201080115150.32597-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10201080115150.32597-100000@master.linux-ide.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Jan 2002, Andre Hedrick wrote:

> ---------- Forwarded message ----------
> Date: Sat, 5 Jan 2002 14:17:00 -0500 (EST)
> From: Rob Radez <rob@osinvestor.com>
> To: Andre Hedrick <andre@linux-ide.org>
> Subject: IDE Patch
> 
> Hi,
> I'm using your ide.2.4.16.12102001 patch with a Promise PDC20269
> controller and a Maxtor 160GB hard drive on 2.4.17, and I just wanted to
> tell you that it's working great so far.

So I took that patch that Anton Altaparmakov rediffed for 2.4.18-pre2;
it lacks help for these options:

CONFIG_IDEDISK_STROKE
CONFIG_IDE_TASK_IOCTL
CONFIG_IDE_TASKFILE_IO
CONFIG_BLK_DEV_IDEDMA_FORCED
CONFIG_IDEDMA_ONLYDISK

Would you mind adding help for these options?

-- 
Matthias Andree

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."         Benjamin Franklin
