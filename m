Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262588AbVBYBnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262588AbVBYBnx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 20:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262596AbVBYBnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 20:43:53 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:12929 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262588AbVBYBnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 20:43:50 -0500
Subject: Re: realtime patch
From: Lee Revell <rlrevell@joe-job.com>
To: george@mvista.com
Cc: Fabian Fenaut <fabian.fenaut@free.fr>,
       shabanip <shabanip@avapajoohesh.com>, linux-kernel@vger.kernel.org
In-Reply-To: <421E76E6.7090905@mvista.com>
References: <52843.69.93.110.242.1109288252.squirrel@69.93.110.242>
	 <421E6B3D.1030009@free.fr>  <421E76E6.7090905@mvista.com>
Content-Type: text/plain
Date: Thu, 24 Feb 2005 20:43:46 -0500
Message-Id: <1109295826.7301.4.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-24 at 16:52 -0800, George Anzinger wrote:
> Fabian Fenaut wrote:
> > shabanip a ecrit le 25.02.2005 00:37:
> > 
> >> where can i find realtime patchs to kernel 2.6?
> > 
> > 
> > http://sourceforge.net/projects/realtime-lsm/ ?
> 
> What??  NO, they are here:
> 
>    http://redhat.com/~mingo/realtime-preempt/
> 

Lots of people seem to be confused on this.  I even read an lwn.net
article that didn't seem to grok the distinction.

The realtime-preempt patches make the Linux kernel usable for soft and
hard realtime applications.

The realtime LSM just enables the administrator to let selected non-root
users use these capabilities.

The only relationship between the patches is that using the realtime LSM
is rather pointless without the realtime preempt patch, because if the
realtime performance of the Linux kernel isn't good enough, there's no
point in being able to let non root users use it.

Lee



