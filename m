Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132623AbRDBIE0>; Mon, 2 Apr 2001 04:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132640AbRDBIEP>; Mon, 2 Apr 2001 04:04:15 -0400
Received: from quechua.inka.de ([212.227.14.2]:39290 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S132623AbRDBIEC>;
	Mon, 2 Apr 2001 04:04:02 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: bug database braindump from the kernel summit
In-Reply-To: <4.3.2.7.2.20010401153355.00b5d630@mail.fluent-access.com>
Organization: private Linux site, southern Germany
Date: Mon, 02 Apr 2001 10:00:21 +0200
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E14jzGJ-0002wR-00@g212.hadiko.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1)  The idea of letting a bug "expire" is a good one.  One way to do this
> is to incorporate some form of user-base moderation into the bug
> database.  Unlike some of the forum systems, there's no reason why we can't
> have tiers of moderators:  "maintainers" are the clearinghouse people for
> certain portions of the Linux kernel source tree and should have a larger
> voice as to whether a bug is important, redundant, or completely off

As everyone thinking about this perhaps should know, this moderation
system is already used by Bugzilla: A bug report starts out as
"unconfirmed", and people who volunteer to triage bugs and are given
appropriate permission may elevate them to "new" status or resolve
them as invalid. The actual maintainers query the database only for
"new" bugs.

Experience in the Mozilla development community has shown, however,
that this is not as simple as it sounds. There are bug reports which
remain unconfirmed for weeks. People submitting reports have that
nasty feeling that they are being ignored. Really, I don't think it is
a good idea to stamp any bug report as "not to be taken seriously" by
default. It puts off people who know better.

With automatic expiry of unconfirmed reports that would be absolutely
devastating. Hopefully it is clear why. (Any pre-triaging process,
even without expiry, must be done quickly and have enough people who
do this unrewarding work, or it will introduce delays which make the
submissions increasingly worthless.)

I think that some sort of expiry is in order, but perhaps better the
other way around: any report with no progress in a certain amount of
time gets _higher_ priority, so that someone (perhaps a triager) is
"forced" to do _something_ about it (and if it's only to close an
issue which has long been fixed or is invalid from the start).

Bugzilla also does address some of the other issues presented here.
(No, I don't think it's perfect :-)

Olaf
