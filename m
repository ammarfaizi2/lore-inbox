Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265438AbSKFTFu>; Wed, 6 Nov 2002 14:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265953AbSKFTFu>; Wed, 6 Nov 2002 14:05:50 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:63909 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S265438AbSKFTFt>;
	Wed, 6 Nov 2002 14:05:49 -0500
Date: Wed, 6 Nov 2002 14:12:28 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
X-X-Sender: <calin@rtlab.med.cornell.edu>
To: <linux-kernel@vger.kernel.org>
Subject: /prod/PID-related proc fs question
Message-ID: <Pine.LNX.4.33L2.0211061403360.5858-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just noticed something today that I found odd and I know there must be a
good reason for it, but I can't think of what it might be..

Basically if I am listing the contents of a /proc/PID directory, it seems
that the cwd, exe, and root (symlink) entries are invalid unless the
process corresponding to PID is a process owned by me, or I am root.  Why
is this?

Is this feature security related?

If so I can't really think of any security issues that would arise from
having that information as a non-priviledged user.

It would seem reasonable to me that users seeing each other's
/prod/PID/root and /proc/PID/exe symlinks isn't really much of a security
vulnerability.. Plus it would make possible a non-root user to grab
statistics on the most popular running binaries, the number of chrooted
processes.. etc..  probably trivial statistics but it still would be nice
to see if any other instance of an application is running (unless there
already is another mechanism for this that I am unaware of).

Anyway any answers appreciated...

-Calin



