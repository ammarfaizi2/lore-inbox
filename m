Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313563AbSDLMiC>; Fri, 12 Apr 2002 08:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313564AbSDLMiB>; Fri, 12 Apr 2002 08:38:01 -0400
Received: from coffee.Psychology.McMaster.CA ([130.113.218.59]:62636 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S313563AbSDLMiB>; Fri, 12 Apr 2002 08:38:01 -0400
Date: Fri, 12 Apr 2002 08:41:35 -0400 (EDT)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: <hahn@coffee.psychology.mcmaster.ca>
To: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Event logging vs enhancing printk
In-Reply-To: <3CB6A92D.452B85E8@bull.net>
Message-ID: <Pine.LNX.4.33.0204120836060.22605-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you make sure with printk-s that no error log is lost, can
> you tell when a log has actually reached a permanent store device ?

I see no reason to believe that evlog would behave any differently
from printk in this regard.

> Can you pass lots of data through a printk ?

yes, of course you can, and it's just as stupid as passing a lot of 
data through evlog.

> Can you make sure that printks are not intermixed ?

show why this is a serious problem.

> I was glad to find this error log feature that meets our requirements.
> It provides us services which reduce our development cost and provides
> us functionality at "usual industrial level" (see e.g. POSIX).

frankly, evlog is a solution in search of a problem.  I see no reason
printk can't do TSC timestamping, more robust and/or efficient buffering,
auto-classification in klogd, realtime filtering/notification in userspace,
even delaying of formatting, and logging of binary data.

regards, mark hahn.

