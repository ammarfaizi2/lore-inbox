Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263163AbUFBPRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbUFBPRq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 11:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbUFBPRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 11:17:46 -0400
Received: from mail.kroah.org ([65.200.24.183]:21655 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263167AbUFBPRV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 11:17:21 -0400
Date: Wed, 2 Jun 2004 08:16:17 -0700
From: Greg KH <greg@kroah.com>
To: Eric BEGOT <eric_begot@yahoo.fr>
Cc: Manu Abraham <manu@kromtek.com>, linux-kernel@vger.kernel.org
Subject: Re: Minor numbers under 2.6
Message-ID: <20040602151617.GA25862@kroah.com>
References: <200406021519.32128.manu@kromtek.com> <20040602144931.GA25424@kroah.com> <40BDEDF6.1030405@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BDEDF6.1030405@yahoo.fr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 05:10:46PM +0200, Eric BEGOT wrote:
> Greg KH wrote:
> 
> >The same way:
> >	# mknod foo c 100 10000
> >	# ls -l foo 
> >	crw-r--r--  1 root root 100, 10000 Jun  2 07:48 foo
> >
> >
> > 
> >
> Under 2.6.7-rc2-mm1 :
> root@Starbuck:/home/tyler>mknod /dev/test c 100 1000
> root@Starbuck:/home/tyler>ll /dev/test
> crw-r--r-- 1 root root 103, 232 Jun 2 17:07 /dev/test
> 
> and under 2.4.26 that's the same.

Like I stated in my message, which you cut off:
	Just make sure you have a up to date glibc.

I'm guessing that you do not have the most recent version of glibc on
your machine.

greg k-h
