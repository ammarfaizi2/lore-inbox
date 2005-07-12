Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262275AbVGLTdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbVGLTdg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 15:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbVGLTdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 15:33:32 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.82]:11166 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S262320AbVGLTcf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 15:32:35 -0400
From: Jeremy Maitin-Shepard <jbms@cmu.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux On-Demand Network Access (LODNA)
References: <20050712160720.36388.qmail@web54403.mail.yahoo.com>
	<42D41096.4000209@namesys.com>
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-1: winter into spring
Date: Tue, 12 Jul 2005 15:32:40 -0400
In-Reply-To: <42D41096.4000209@namesys.com> (Hans Reiser's message of "Tue, 12
	Jul 2005 11:48:54 -0700")
Message-ID: <87oe976crr.fsf@jbms.ath.cx>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe he is suggesting the addition of an sshfs, ftpfs, webdavfs,
etc. to the kernel, and allowing unprivileged users to mount these
filesystems.  (As a side note, I find it somewhat peculiar that he
includes smbfs in an example, since that is already implemented in the
kernel.)  Although he refers to possible implementation of these
facilities as reiserfs 4 plugins, it would seem far more straightforward
and useful to implement them as separate filesystems.  In fact, many of
these facilities already exist as filesystems for Linux.  For instance,
there is an sshfs program for FUSE, and FUSE already provides the
unprivileged mounting support mentioned in the proposal.

-- 
Jeremy Maitin-Shepard
