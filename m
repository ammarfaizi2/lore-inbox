Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262915AbVCDNNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262915AbVCDNNV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 08:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbVCDNMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 08:12:25 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:21269 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262871AbVCDNFE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 08:05:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=ofidDVzyMkIAcN5TOeNRb7V+YjCSA0xX0MjXkcy9kZGXUrl/6q7gFFfgL6Bd7yYODmCwrMNrXryIcmkN09FTnp1nrasxTtLmPU/MezpyFPWO4rO5bSsFozUpgdsiG+XAJelAcYDHvx7crM+2EgFKSewujrYRdWYfshznJuojuKU=
Date: Fri, 4 Mar 2005 14:04:53 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: davej@redhat.com, akpm@osdl.org, torvalds@osdl.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-Id: <20050304140453.697ac6d1.diegocg@gmail.com>
In-Reply-To: <20050304110633.C3932@flint.arm.linux.org.uk>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
	<20050302230634.A29815@flint.arm.linux.org.uk>
	<42265023.20804@pobox.com>
	<Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org>
	<20050303002733.GH10124@redhat.com>
	<20050302203812.092f80a0.akpm@osdl.org>
	<20050303052100.GA22952@redhat.com>
	<20050303214358.3c842a01.diegocg@gmail.com>
	<20050304110633.C3932@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 1.9.4+svn (GTK+ 2.6.2; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Fri, 4 Mar 2005 11:06:33 +0000,
Russell King <rmk+lkml@arm.linux.org.uk> escribió:

> Overall, my experience with the kernel bugzilla has been rather
> unproductive.  Most bugs which came in my direction weren't for things
> I could resolve.


It's possible that there're other bug tracking systems that can fit? The main disadvantage 
of the (few) bug tracking systems I've seen is that at the end they end up being a
"additional task" for the developers (ie: more work) instead of being something that really
helps to developers and free them of doing some extra work, so people avoids them when
they can. There're some mail-based bug tracking systems like the one from debian but
they don't include a alternative web interface for final users (well, I think bugzilla has a
"email mode" or something like that but I don't really know)


Bug reporters running away is something that will happen always no matter what system
is used, but is it important? If someone submits a bug and he don't answer when 
he's asked for more details, there's no way you can fix it and the bug should be closed
given a reasonable time frame. There's no reason why this can't happen today when bug
are reported to the lkml, except that people who reports bugs to the lkml is people who
really wants to get their bugs fixed. If the bug is important enought, it'll get reported again
by someone else who cares about getting it fixed.

(There're other problems with traditional bug tracking systems, like "ownership" of a bug.
Some bugs are reported, discussed, and then they get fixed silently outside of the
scope of the bug tracking system, but the bug remains open for _years_ - IMHO all open
bugs which have not been discussed and closed in such amount of time should be
closed unless there're real reasons to keep them open, new versions could have fixed
it and if it remains it could be re-submitted - and it can't get closed because the developer
who owns it is not looking at it. Some bug tracking systems (like the one from joel spolsky,
aka "joelonsoftware.com") just don't allow to have "ownership" of bugs, because if you
want that the system helps to solve problems instead of being an additional task,
_everyone_ should be allowed to solve problems - which is specially true in the open
source world)
