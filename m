Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284662AbRLIXyb>; Sun, 9 Dec 2001 18:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284675AbRLIXyV>; Sun, 9 Dec 2001 18:54:21 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:5254 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S284662AbRLIXyN>;
	Sun, 9 Dec 2001 18:54:13 -0500
Date: Sun, 9 Dec 2001 14:53:52 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] 2.5.0 Multi-Queue Scheduler
Message-ID: <20011209145352.C1087@w-mikek2.sequent.com>
In-Reply-To: <20011209143152.A1087@w-mikek2.sequent.com> <E16DDj6-0008H8-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16DDj6-0008H8-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Dec 09, 2001 at 11:51:20PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2001 at 11:51:20PM +0000, Alan Cox wrote:
> Tasks with roughly the same priority will not neccessarily run in strict
> priority order but they will get appropriate extra time and run before
> anything measurably different in priority.

That makes it much easier.  When we tried this, we were going for
strict priority.  Therefore, you either had a really large number
of queues, or you had to scan all tasks on individual queues.  Again,
we were trying to maintain existing behavior.  In hind sight, this
doesn't look like a smart design constraint. :)

-- 
Mike
