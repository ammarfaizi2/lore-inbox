Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267362AbTAGJxj>; Tue, 7 Jan 2003 04:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267363AbTAGJxi>; Tue, 7 Jan 2003 04:53:38 -0500
Received: from mta.sara.nl ([145.100.16.144]:55965 "EHLO mta.sara.nl")
	by vger.kernel.org with ESMTP id <S267362AbTAGJxh>;
	Tue, 7 Jan 2003 04:53:37 -0500
Date: Tue, 7 Jan 2003 11:02:06 +0100
From: Remco Post <r.post@sara.nl>
To: thockin@sun.com
Cc: th122948@scl2.sfbay.sun.com, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [BK SUMMARY] remove 32 group limit (re-send)
Message-Id: <20030107110206.469a98e5.r.post@sara.nl>
In-Reply-To: <200301062329.h06NTZf24210@scl2.sfbay.sun.com>
References: <200301062329.h06NTZf24210@scl2.sfbay.sun.com>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; sparc-sun-solaris2.7)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jan 2003 15:29:34 -0800 (PST)
Timothy Hockin <th122948@scl2.sfbay.sun.com> wrote:

> Linus,
> 
> I've sent this a bunch of times.  I don't know if it is just getting
> dropped or if there is some reason you don't want it in.  Could you please
> either explain why it will never go in or what needs to be fixed for it to
> go in?
> 
> This patch removes the hard NGROUPS limit.  It has been in use in a
> similar form on our systems for some time.  I've sent it several times,
> and it has evolved a lot from the original form.  I've had no complaints
> from anyone about this version of the patch.

Wasn't there something about groups and NFS? I remember configuring solaris
once to allow for more than 32 groups for a single user, and NFS for those
users that we in more than 32 groups would break horribly. Granted, one
should not use NFS, if it can be avoided, nor is it reasonable to impose NFS
limitations on environments that don't use NFS, still, I think it's a good
thing to ehh, maybe have to enable the use of more than 32 groups in some
/proc file....

Oh btw. In none of our current environments, we actually run into this 32
group limit, not even in the really big ones.....

-- 
Met vriendelijke groeten,

Remco Post

SARA - Stichting Academisch Rekencentrum Amsterdam    http://www.sara.nl
High Performance Computing  Tel. +31 20 592 8008    Fax. +31 20 668 3167

"I really didn't foresee the Internet. But then, neither did the computer
industry. Not that that tells us very much of course - the computer industry
didn't even foresee that the century was going to end." -- Douglas Adams
