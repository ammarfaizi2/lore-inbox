Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262488AbSJKPEz>; Fri, 11 Oct 2002 11:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262506AbSJKPEz>; Fri, 11 Oct 2002 11:04:55 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:32524 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S262488AbSJKPEy>; Fri, 11 Oct 2002 11:04:54 -0400
Date: Fri, 11 Oct 2002 16:10:34 +0100
From: John Levon <levon@movementarian.org>
To: Thierry Mallard <thierry.mallard@vawis.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: schedule_task still available in 2.5.41 ? (working on nvidia kernel module driver, but maybe not related)
Message-ID: <20021011151033.GA13277@compsoc.man.ac.uk>
References: <20021011150505.GA1684@d133.dhcp212-198-6.noos.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021011150505.GA1684@d133.dhcp212-198-6.noos.fr>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *1801Qw-000G80-00*B.32RtQjbSs* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2002 at 05:05:05PM +0200, Thierry Mallard wrote:

> nv.c:1679: warning: implicit declaration of function `schedule_task'

It's schedule_work() now. Read kernel/workqueue.c

john

-- 
"That's just kitten-eating wrong."
	- Richard Henderson
