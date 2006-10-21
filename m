Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992827AbWJUFcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992827AbWJUFcX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 01:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWJUFcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 01:32:23 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:58870 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932222AbWJUFcW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 01:32:22 -0400
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: [ANNOUNCE] GIT 1.4.3.1
cc: linux-kernel@vger.kernel.org
Date: Fri, 20 Oct 2006 22:32:19 -0700
Message-ID: <7v4ptyi68s.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest maintenance release GIT 1.4.3.1 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.4.3.1.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.4.3.1.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.4.3.1.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.4.3.1-1.$arch.rpm	(RPM)

This is primarily to work around changes in the recent GNU diff output
format.  Also it contains irritation fix for "git diff" which now
paginates its output by default.

----------------------------------------------------------------

Changes since v1.4.3 are as follows:

Junio C Hamano (1):
      pager: default to LESS=FRS

Lars Hjemli (1):
      Fix typo in show-index.c

Linus Torvalds (1):
      git-apply: prepare for upcoming GNU diff -u format change.

Nguyễn Thái Ngọc Duy (2):
      Reject hexstring longer than 40-bytes in get_short_sha1()
      Add revspec documentation for ':path', ':[0-3]:path' and git-describe

Nicolas Pitre (1):
      reduce delta head inflated size


