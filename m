Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262326AbVCIMjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262326AbVCIMjZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 07:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbVCIMjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 07:39:25 -0500
Received: from alog0100.analogic.com ([208.224.220.115]:36224 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262326AbVCIMjR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 07:39:17 -0500
Date: Wed, 9 Mar 2005 07:36:14 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
cc: linux-kernel@vger.kernel.org, arjan@infradead.org,
       alan@lxorguk.ukuu.org.uk, martin.frey@scs.ch
Subject: Re: "remap_page_range" compile ERROR
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB348113A4897@mail.esn.co.in>
Message-ID: <Pine.LNX.4.61.0503090734200.18193@chaos.analogic.com>
References: <4EE0CBA31942E547B99B3D4BFAB348113A4897@mail.esn.co.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2005, Mukund JB. wrote:

>
> Hi all,
>
> I am running Redhat 9 Linux.
> I have problem with compiling the i810fb driver downloaded from
> Sourceforge site. I have D/W the i810fb patch
> "linux-i810fb-0.0.35.tar.bz2".
>
> When I run the make modules I get the following ERROR
>
> i810_main.c: 643: warning: passing arg 1 of 'remap_page_range_R2baf18f2'
> makes pointer from integer without a cast
> i810_main.c: 643: incompatible type for argument 4 of
> 'remap_page_range_R2baf18f2'
> i810_main.c: 643: too few arguments to function
> 'remap_page_range_R2baf18f2'
> Make[3]: *** [I810_main.c] Error 1
> ........
> ......
>
> The call to "remap_page_range()" is as follows:-
>
> return (io_remap_page_range(vma->vm_start, off, vma->vm_end -
> vma->vm_start, vma->vm_page_prot)) ? -EAGAIN : 0;
>
>
> Please suggest me what could be the problem.
>
> Regards,
> Mukund jampala
>
>


It now gets vma as the first argment as well as the others.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
