Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262178AbSIZE3O>; Thu, 26 Sep 2002 00:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262177AbSIZE3O>; Thu, 26 Sep 2002 00:29:14 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:54793 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262180AbSIZE2R>;
	Thu, 26 Sep 2002 00:28:17 -0400
Date: Wed, 25 Sep 2002 21:32:09 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 4/4] increase traffic on linux-kernel
Message-ID: <20020926043208.GD1790@kroah.com>
References: <3D928864.23666D93@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D928864.23666D93@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2002 at 09:09:08PM -0700, Andrew Morton wrote:
> 
> Infrastructure to detect sleep-inside-spinlock bugs.  Really only
> useful if compiled with CONFIG_PREEMPT=y.  It prints out a whiny
> message and a stack backtrace if someone calls a function which might
> sleep from within an atomic region.

Why not make this it's own config option, dependent on CONFIG_PREEMPT?

thanks,

greg k-h
