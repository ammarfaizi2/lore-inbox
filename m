Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267775AbTBVCbQ>; Fri, 21 Feb 2003 21:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267778AbTBVCbQ>; Fri, 21 Feb 2003 21:31:16 -0500
Received: from msp-24-163-212-250.mn.rr.com ([24.163.212.250]:34189 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S267775AbTBVCbP>; Fri, 21 Feb 2003 21:31:15 -0500
Subject: Re: 2.5.62-mm2
From: Shawn <core@enodev.com>
To: Ed Tomlinson <tomlins@cam.org>
Cc: Andrew Morton <akpm@digeo.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <200302212048.09802.tomlins@cam.org>
References: <20030220234733.3d4c5e6d.akpm@digeo.com>
	 <200302212048.09802.tomlins@cam.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045881657.27435.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 21 Feb 2003 20:40:58 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason, I had to boot single, then go to multi user.

Otherwise, I got some sort  of interrupt not free messages after my
second ide ctrlr got recognized.

On Fri, 2003-02-21 at 19:48, Ed Tomlinson wrote:
> On February 21, 2003 02:47 am, Andrew Morton wrote:
> > So this tree has three elevators (apart from the no-op elevator).  You can
> > select between them via the kernel boot commandline:
> >
> >         elevator=as
> >         elevator=cfq
> >         elevator=deadline
> 
> Has anyone been having problems booting with 'as'?  It hangs here at the point
> root gets mounted readonly.  cfq works ok.
> 
> 
> 
> If this has already been reported sorry - mail is lagging here.
> 
> Ed Tomlinson
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
