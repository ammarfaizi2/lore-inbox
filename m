Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313898AbSFTOSq>; Thu, 20 Jun 2002 10:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314451AbSFTOSp>; Thu, 20 Jun 2002 10:18:45 -0400
Received: from noc.mainstreet.net ([207.5.0.45]:50705 "EHLO noc.mainstreet.net")
	by vger.kernel.org with ESMTP id <S313898AbSFTOSo>;
	Thu, 20 Jun 2002 10:18:44 -0400
From: devnull@adc.idt.com
Date: Thu, 20 Jun 2002 10:18:25 -0400 (EDT)
X-X-Sender: <ram@bom.adc.idt.com>
Reply-To: <devnull@adc.idt.com>
To: Brian Gerst <bgerst@didntduck.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: >3G Memory support
In-Reply-To: <3D114C27.4000801@quark.didntduck.org>
Message-ID: <Pine.GSO.4.31.0206201010340.13158-100000@bom.adc.idt.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > When i compiled my kernel, i set CONFIG_HIGHMEM4G.
> >
> > Does this mean that all my programs should be able to address 4G ?
>
> No.  It means the kernel can access all 4GB of memory.  For memory above
> the 950MB that it can directly map, it needs to use dynamic mappings
> (kmap).  User space is always 3GB virtual space per process, regardless
> of the highmem setting.

Is there a way to make a process in the user space to able to access 4GB
at all. What limits user space to 3GB.

If not in current 2.4.x / 2.5.x, is this something planned in the future
releases ?

Thanks for your time.

Regards,

/dev/null

devnull@adc.idt.com



