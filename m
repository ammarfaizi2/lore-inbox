Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262687AbUKXRZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbUKXRZp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 12:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262668AbUKXRZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 12:25:08 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18439 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262759AbUKXREe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 12:04:34 -0500
Date: Wed, 24 Nov 2004 18:04:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 4th SCSI Driver Compiliation Error w/GCC-3.4.2
Message-ID: <20041124170431.GC19873@stusta.de>
References: <Pine.LNX.4.61.0411240838480.19627@p500>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411240838480.19627@p500>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2004 at 08:39:09AM -0500, Justin Piszcz wrote:
>   CC [M]  drivers/scsi/qla2xxx/qla_os.o
> drivers/scsi/qla2xxx/qla_os.c: In function `qla2x00_queuecommand':
> drivers/scsi/qla2xxx/qla_os.c:315: sorry, unimplemented: inlining failed 
> in call to 'qla2x00_callback': function not considered for inlining
>...

Known problem, fixed since 2.6.10-rc1 .

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

