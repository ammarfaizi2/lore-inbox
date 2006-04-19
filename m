Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWDSTWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWDSTWg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 15:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWDSTWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 15:22:36 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:5867 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751092AbWDSTWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 15:22:34 -0400
Date: Wed, 19 Apr 2006 21:22:07 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Greg KH <greg@kroah.com>
cc: James Morris <jmorris@namei.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       T?r?k Edwin <edwin@gurde.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation
 of LSM hooks)
In-Reply-To: <20060419154011.GA26635@kroah.com>
Message-ID: <Pine.LNX.4.61.0604192109220.7177@yvahk01.tjqt.qr>
References: <200604072138.35201.edwin@gurde.com>
 <1144863768.32059.67.camel@moss-spartans.epoch.ncsc.mil>
 <200604142301.10188.edwin@gurde.com> <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil>
 <20060417162345.GA9609@infradead.org> <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil>
 <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei>
 <20060417195146.GA8875@kroah.com> <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr>
 <20060419154011.GA26635@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 
>> Well then, have a look at http://alphagate.hopto.org/multiadm/
>> 
>> There is a reason to why people [read: I] do not submit out-of-tree
>> (OOT) modules; because I think chances are low that they get in. Sad
>> fact about the Linux kernel.
>
>Why do you feel this way.  We document how to get patches applied very
>well (look in Documentation/SubmittingPatches and
>Documentation/HOWTO), and provide good review comments on anything
>that is posted.
>

In case of MultiAdm: It adds some more LSM hooks, some of which have
received a frown.[1] And it adds a ton of changes scattered throughout
the kernel (namely replacing capable() with capable_x()) -- I would
suppose these would be ignored to death even more than [1]. Just look
at the 2.6.15-mtadm.diff within the multiadm package.

In general: I am probably too strongly tied to my own CodingStyle to
change it for Documentation/CodingStyle. (Regarding tabs-vs-space. I'm
flexible about indent level.) After all, I have to maintain it... If
someone else makes the necessary adjustments, let it be.

>We also have a kernel-mentors mailing list that people use to vet
>their patches to get them into shape for submission.
>
>So please feel free to submit your patch, especially as without
>another LSM user in the kernel tree, the interface will probably go
>away.


[1] http://tinyurl.com/opo8h
    (long url below, should the tinyurl go away someday)



Jan Engelhardt
-- 
[1] http://groups.google.com/group/fa.linux.kernel/browse_frm/thread/ef106f193befdbe5/79896dc45b0d5944?lnk=st&q=security_task_post_setgid+author%3AJan+author%3AEngelhardt&rnum=1&hl=en#79896dc45b0d5944
