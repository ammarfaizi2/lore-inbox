Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752694AbWKLFXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694AbWKLFXW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 00:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754971AbWKLFXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 00:23:22 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:56468 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1752694AbWKLFXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 00:23:21 -0500
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: [ANNOUNCE] GIT 1.4.3.5
cc: linux-kernel@vger.kernel.org
Date: Sat, 11 Nov 2006 21:23:20 -0800
Message-ID: <7v64dli6gn.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest maintenance release GIT 1.4.3.5 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.4.3.5.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.4.3.5.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.4.3.5.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.4.3.5-1.$arch.rpm	(RPM)

The 'master' front has been very quiet and it will hopefully
soon produce 1.4.4 but in the meantime here is primarily to fix
git-svn correctness issues.

----------------------------------------------------------------

Changes since v1.4.3.4 are as follows:

Alex Riesen (1):
      merge-recursive implicitely depends on trust_executable_bit

Eric Wong (3):
      git-svn: avoid printing filenames of files we're not tracking
      git-svn: don't die on rebuild when --upgrade is specified
      git-svn: fix dcommit losing changes when out-of-date from svn

Jakub Narebski (1):
      Documentation: Transplanting branch with git-rebase --onto

Jeff King (1):
      Fix git-runstatus for repositories containing a file named HEAD

Junio C Hamano (3):
      adjust_shared_perm: chmod() only when needed.
      path-list: fix path-list-insert return value
      git-cvsserver: read from git with -z to get non-ASCII pathnames.

Petr Baudis (1):
      Nicer error messages in case saving an object to db goes wrong

Robert Shearman (1):
      git-rebase: Use --ignore-if-in-upstream option when executing git-format-patch.

Tero Roponen (1):
      remove an unneeded test


