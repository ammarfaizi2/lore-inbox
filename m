Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315458AbSGDX5T>; Thu, 4 Jul 2002 19:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315440AbSGDX4d>; Thu, 4 Jul 2002 19:56:33 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:64415 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315439AbSGDXzt>;
	Thu, 4 Jul 2002 19:55:49 -0400
Date: Thu, 4 Jul 2002 19:58:22 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Dave Hansen <haveblue@us.ibm.com>
cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove BKL from driverfs
In-Reply-To: <3D24DC8C.4060801@us.ibm.com>
Message-ID: <Pine.GSO.4.21.0207041953370.12731-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Jul 2002, Dave Hansen wrote:

> CC'ing Al for comments...
> 
> Greg KH wrote:
> > bleah, a proliferation of a zillion little spinlocks all across the
> > kernel is not my idea of fun :(
> 
> A zillion locks each with a single purpose is a lot more fun than 1 
> lock with a zillion different uses.

Wrong.  It's fun if you are into taking a turd and turning it into a thin film
spread over all available surfaces.  The former has a chance to be removed.
The latter is hopeless.

"Zillion little spinlocks" means that kernel is scaled into oblivion.
Literally.  If you want to play with resulting body - feel free, but
I like it less kinky.

