Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932527AbWCGAdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbWCGAdp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 19:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbWCGAdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 19:33:45 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:10659 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932527AbWCGAdp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 19:33:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fnVJ2Vu9NGe9SAN1V64IFFLBSbFrVbhckLcjYrg+8tA0S8IK3dK+H8ctTdGRQXbcCst9iNkftG5pnR23oU1btvMctRTxxNMjJdHVSd8b9NFp94LJZa4Us/OnZ44BQ2+ak9ufE1b+pqUXMzsJczAxRnHX0ee09NiZdZ9hJ/xOwxk=
Message-ID: <35fb2e590603061633w2dd7fff4m63e73ee8ed409951@mail.gmail.com>
Date: Tue, 7 Mar 2006 00:33:44 +0000
From: "Jon Masters" <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: [OT] inotify hack for locate
Cc: "Helge Hafting" <helge.hafting@aitel.hist.no>,
       "Chris Ball" <cjb@mrao.cam.ac.uk>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <1141690310.25487.97.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <35fb2e590603051336t5d8d7e93i986109bc16a8ec38@mail.gmail.com>
	 <yd3bqwkbgsi.fsf@islay.ra.phy.cam.ac.uk>
	 <35fb2e590603051704k120e0257wb39c3e3eb1cf0b49@mail.gmail.com>
	 <440C0175.7040909@aitel.hist.no> <1141690310.25487.97.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/06, Lee Revell <rlrevell@joe-job.com> wrote:
> On Mon, 2006-03-06 at 10:31 +0100, Helge Hafting wrote:
> > As for the non-existent virus problem - it is mostly prevented
> > by users not being administrators.  And you can go further
> > with a readonly /usr and a noexec /home.

> I believe he is referring to using Linux systems to provide virus
> scanning services for mail, NFS, SMB etc. clients, rather than to virus
> scanning for the Linux desktop (which is indeed a non problem).

Sure. I wasn't hand waving an muttering about virus problems on Linux
desktops everywhere.

Anyway. Seems a couple of us are interested in having something more
generic at the VFS level to notify userspace about particular events
of interest (recursively registering a watcher on every directory is
silly). I really should go scope out some of the existing projects
that cover this before I decide what to do. This kind of thing should
be in mainline IMHO.

Jon.
