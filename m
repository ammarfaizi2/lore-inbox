Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbVJRFxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbVJRFxx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 01:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbVJRFxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 01:53:53 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:13460 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932387AbVJRFxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 01:53:52 -0400
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: GIT 0.99.8e
References: <7vachadnmy.fsf@assigned-by-dhcp.cox.net>
Date: Mon, 17 Oct 2005 22:53:50 -0700
In-Reply-To: <7vachadnmy.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 15 Oct 2005 22:41:41 -0700")
Message-ID: <7v8xwrtlox.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GIT 0.99.8e is available as usual at:

    RPMs and tarball: www.kernel.org:/pub/software/scm/git/
    Debs and tarball: www.kernel.org:/pub/software/scm/git/debian/

The "master" branch has updated "git-diff-*" commands, that deal
with pathnames with funny characters (most importantly tabs and
newlines) in a way compatible with the proposed change to GNU
patch, which was outlined in:

    http://marc.theaimsgroup.com/?l=git&m=112927316408690&w=2

When people start generating diffs with them, patches that touch
paths that have double-quotes '"' or spaces ' ' in them need to
be applied with the updated git-apply that knows how new
"git-diff-*" encodes these funny pathnames.  GIT 0.99.8e
contains the necessary backport of the git-apply changes.

This will hopefully be the last 0.99.8 maintenance release.


