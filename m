Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbWFYRSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWFYRSp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 13:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWFYRSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 13:18:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35459 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751329AbWFYRSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 13:18:44 -0400
Date: Sun, 25 Jun 2006 10:18:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm2 (NULL pointer dereference)
Message-Id: <20060625101840.4f90da21.akpm@osdl.org>
In-Reply-To: <200606251825.26614.dominik.karall@gmx.net>
References: <20060624061914.202fbfb5.akpm@osdl.org>
	<200606251825.26614.dominik.karall@gmx.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jun 2006 18:25:26 +0200
Dominik Karall <dominik.karall@gmx.net> wrote:

> On Saturday, 24. June 2006 15:19, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1
> >7/2.6.17-mm2/
> 
> hi!
> 
> I got this error with 2.6.17-mm1 too, I took a picture with my mobile, 
> hope it's readable:
> http://stud4.tuwien.ac.at/~e0227135/kernel/060625_180209.jpg
> 

hm, that's new.  We do seem to be getting a few sysfs/kobject crashes in
there.

Do you actually have the bttv hardware present?
