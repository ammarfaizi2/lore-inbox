Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVAGRji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVAGRji (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 12:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbVAGRjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 12:39:37 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:27121 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261374AbVAGRjQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 12:39:16 -0500
Date: Fri, 7 Jan 2005 09:39:16 -0800
From: Greg KH <greg@kroah.com>
To: Ikke <ikke.lkml@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kobject_uevent
Message-ID: <20050107173916.GB15417@kroah.com>
References: <297f4e01050107065060e0b2ad@mail.gmail.com> <297f4e0105010707142be80168@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <297f4e0105010707142be80168@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 04:14:07PM +0100, Ikke wrote:
> Next to this, there seems to be a mistake in the 2.6.10 changelog: it writes
> [quote]
> kobject_uevent(const char *signal,
> 	                 struct kobject *kobj,
> 	                 struct attribute *attr)
> [/quote]
> whilst include/linux/kobject_uevent.h defines
> [quote]
> int kobject_uevent(struct kobject *kobj,
>                    enum kobject_action action,
>                    struct attribute *attr);
> [/quote]
> which is something completely different.

Look further on in the changelog where I changed the api to the current
one :)

thanks,

greg k-h
