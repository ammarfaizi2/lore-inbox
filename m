Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316185AbSEaQkZ>; Fri, 31 May 2002 12:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316223AbSEaQkY>; Fri, 31 May 2002 12:40:24 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:15369 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316185AbSEaQkX>;
	Fri, 31 May 2002 12:40:23 -0400
Date: Fri, 31 May 2002 09:38:36 -0700
From: Greg KH <greg@kroah.com>
To: Stelian Pop <stelian.pop@fr.alcove.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: USB host drivers test results (2.5.19) and problem.
Message-ID: <20020531163836.GA1250@kroah.com>
In-Reply-To: <20020531133429.GF8310@come.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Fri, 03 May 2002 14:47:14 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2002 at 03:34:29PM +0200, Stelian Pop wrote:
> 1. Shouldn't the ehci/ohci drivers give some error on loading,
> since I obviously don't have the hardware ?

Yes, they should not load.  I'll try to look into this.

> 2 When doing a rmmod on one of the two last drivers, 
> the kernel oopses with a (hand copied trace):

If you remove _any_ pci driver module from 2.5.19 you get an oops, this
isn't limited to the USB drivers right now :)

thanks,

greg k-h
