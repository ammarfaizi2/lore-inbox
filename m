Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267343AbTAQAur>; Thu, 16 Jan 2003 19:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267344AbTAQAuq>; Thu, 16 Jan 2003 19:50:46 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:41427 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267343AbTAQAuq>; Thu, 16 Jan 2003 19:50:46 -0500
Date: Fri, 17 Jan 2003 01:59:41 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Jeroen van Disseldorp <jdizzl@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Detecting changes in a directory tree
Message-ID: <20030117005941.GT2333@fs.tum.de>
References: <200301161358.36497.jdizzl@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301161358.36497.jdizzl@xs4all.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2003 at 01:58:36PM -0500, Jeroen van Disseldorp wrote:

> Hi,

Hi Jeroen,

> For an application I'm writing I need to know if files in a certain 
> directory tree were modified and/or deleted by another process. I 
> assume that that tree is mounted on the machine that my app is running 
> on. The device it has mounted on can be a local HD, but it can also be 
> hosted remotely and mounted over nfs.
> 
> I know of FAM, but this is documented to only watch a directory 1 level 
> deep, and I need the whole tree to be monitored. Does anyone know a 
> solution for this? Does the kernel provide facilities for this?
>...

with a kernel >= 2.4.19 dnotify [1] might do what you want.

> Regards,
>   Jeroen van Disseldorp         mailto:jdizzl@xs4all.nl

cu
Adrian

[1] http://www.student.lu.se/~nbi98oli/dnotify.html

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

