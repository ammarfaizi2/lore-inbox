Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313882AbSDWFGI>; Tue, 23 Apr 2002 01:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314212AbSDWFGH>; Tue, 23 Apr 2002 01:06:07 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:31100 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S313882AbSDWFGG>; Tue, 23 Apr 2002 01:06:06 -0400
Date: Tue, 23 Apr 2002 01:05:36 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200204230505.g3N55a815308@devserv.devel.redhat.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] race in request_module()
In-Reply-To: <mailman.1019523121.12485.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * there is no way to distinguish between failing modprobe and successful
>   one followed by rmmod -a (e.g. called by cron).  For one thing, we
>   don't pass exit value of modprobe to caller of request_module().

> Comments?

Please do not concern yourself with rmmod -a running from cron.
For one thing, it helpfuly removes your USB keyboard support.
I do not think any distributions install it anymore.

-- Pete
