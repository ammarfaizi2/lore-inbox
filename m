Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314637AbSEFSGh>; Mon, 6 May 2002 14:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314645AbSEFSGg>; Mon, 6 May 2002 14:06:36 -0400
Received: from mnh-1-28.mv.com ([207.22.10.60]:62217 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S314637AbSEFSGf>;
	Mon, 6 May 2002 14:06:35 -0400
Message-Id: <200205061905.OAA03838@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: hugang <gang_hu@soul.com.cn>
cc: Pavel Machek <pavel@suse.cz>, jdike@karaya.com, glonnon@ridgerun.com,
        seasons@fornax.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATH] Port software suspend to UML. 
In-Reply-To: Your message of "Tue, 07 May 2002 00:17:53 +0800."
             <20020507001753.71406c1d.gang_hu@soul.com.cn> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 May 2002 14:05:14 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gang_hu@soul.com.cn said:
> -- Now The kernel can read the swap data into memory. possible
> somethinks is lost , the kernel can not switch the register to old.  

At the point at which you're trying to restore the old registers, you need
to have recreated the host processes and their state.  So, if you're going
to get any further, you need to start saving that state.

				Jeff

