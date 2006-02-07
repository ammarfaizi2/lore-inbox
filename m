Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965161AbWBGWPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965161AbWBGWPY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 17:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbWBGWPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 17:15:24 -0500
Received: from thunk.org ([69.25.196.29]:28141 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S965173AbWBGWPV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 17:15:21 -0500
Date: Tue, 7 Feb 2006 17:15:13 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: David Chow <davidchow@shaolinmicro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux drivers management
Message-ID: <20060207221513.GA7394@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	David Chow <davidchow@shaolinmicro.com>,
	linux-kernel@vger.kernel.org
References: <20060207044204.8908.qmail@science.horizon.com> <m1zml3rvkg.fsf@ebiederm.dsl.xmission.com> <43E8F8EB.8010800@shaolinmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E8F8EB.8010800@shaolinmicro.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 03:45:47AM +0800, David Chow wrote:
> - What is the goal of Linux developers? Just for fun? Or you want Linux 
> to get more popular? Users want their system to get supported with 
> latest drivers, not to compile and build to latest kernel. Or not to 
> upgrade their Linux distro every week or month. I don't use 2.6.15 nor 
> happy downloading 40Mb targged gzip kernel source and knowing how to 
> "make" it.

Every Linux developer has their own goals, of course, but for most of
them it is about making the best possible Linux kernel that is
technically possible.  If they have working drivers for their system,
they may not necessarily care about some company's hardware unless,
(a) it impacts them personally, (b) they are paid or employed to worry
about it, or (c) lots of end-users are sending complaining/sending
hate-mail about it.  

(In some cases, end-users send hate mail to the Linux kernel
developers when some idiot company's binary driver modules is buggy
and corrupts the kernel in hard-to-debug ways; one particular video
driver company is especially guilty here, and is viewed by some as
being directly responsible for the tainted kernel flags.)

The assumption by many developers is that if we concetrate on making
Linux as good as possible, it will eventually get popular enough that
hardware vendors will feel a commercial incentive to cooperate with
our way of doing things.  Obviously, this in practice things don't
always work that way --- the Sony Betamax is story is one where
technical excellence doesn't always win out.  However, at least in the
server space, compromising hasn't obviously been a bad strategy, with
many SCSI and FC controller manufacturers deciding on their own to
work with the Linux kernel development community.  (Sometimes with
some help from major system vendors who write in a requirement for a
mainline device driver into the sourcing contracts for said
controllers, but nevertheless, it shows that this stance is not
obviously a bad strategy for Linux kernel developers, at least in the
server space.)

David, you may find this frustrating, and at least in the Deskstop
space, it's likely that your company hasn't seen sourcing contracts
yet where a mainline acceptable device driver is a requirement for
some major system vendor, like Dell, Gateway, HP, etc. to decide to
use your products.  I suspect that if this _was_ the case, your
company would in fact dedicate the full-time engineer necessary to
make a device driver which could be integrated into the mainstream
kernel sources and then could be backported to older distributions.
But if you did, I think it is certainly doable.

But at that point it stops being a technical question of "is it
possible" and moves to an economic question of "are we willing to fund
a full-time engineer to provide support for our hardware under Linux"
and "how popular does the Linux desktop have to be before a system
vendor will feel obliged to put pressure on their downstream suppliers
to provide the necessary driver support"?  And as such, LKML will
probably not be a very useful place to have that discussion.

Regards,

						- Ted
