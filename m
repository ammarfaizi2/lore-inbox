Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266113AbSKFXsQ>; Wed, 6 Nov 2002 18:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266223AbSKFXsQ>; Wed, 6 Nov 2002 18:48:16 -0500
Received: from email.careercast.com ([216.39.101.233]:41433 "HELO
	email.careercast.com") by vger.kernel.org with SMTP
	id <S266113AbSKFXsP>; Wed, 6 Nov 2002 18:48:15 -0500
Subject: Re: build kernel for server farm
From: Matt Simonsen <matt_lists@careercast.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0211061813170.27141-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0211061813170.27141-100000@montezuma.mastecende.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Nov 2002 15:55:02 -0800
Message-Id: <1036626902.1331.30.camel@mattsworkstation>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-06 at 15:13, Zwane Mwaikambo wrote:
> On 6 Nov 2002, Matt Simonsen wrote:
> 
> > First, I plan on compiling the kernel on a development box. From there
> > my plan is basically tar /usr/src/linux, copy to each box, untar, copy
> > bzImage and System.map to /boot, run make modules_install, edit
> > lilo.conf, run lilo.
> > 
> > Tips? Comments?
> 
> Network file system?

For /usr/src and the kernel distribution? Or for the whole boot process?

I use NFS already for several shared filesystems. NFS isn't quite
specific enough that I understand what you mean.

Could you give me a little more detail on exactly what you would use it
for? If I've overlooked a howto or obvious document please RTFM me- I'm
trying to learn from the pros here and would ideally like something that
will scale well to over 100 machines.

Matt


