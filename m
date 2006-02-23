Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWBWB7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWBWB7N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 20:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWBWB7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 20:59:13 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:52697 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750704AbWBWB7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 20:59:12 -0500
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: [ANNOUNCE] GIT 1.2.3
cc: linux-kernel@vger.kernel.org
Date: Wed, 22 Feb 2006 17:59:09 -0800
Message-ID: <7vlkw2kf82.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest maintenance release GIT 1.2.3 is available at the
usual places:

	http://www.kernel.org/pub/software/scm/git/

	git-1.2.3.tar.{gz,bz2}			(tarball)
	RPMS/$arch/git-*-1.2.3-1.$arch.rpm	(RPM)


This contains some documentation updates, and a fix for the
"empty ident not allowed" problem that bit too many people.

Breaking the tradition, this is _not_ a pure bugfix release,
however.  It contains backports of the much talked about "reuse
data from existing pack" optimization from the master branch.

Hopefully this would help downloading from the kernel.org
servers over git native protocol.

----------------------------------------------------------------

Changes since v1.2.2 are as follows:

Carl Worth:
      git-add: Add support for --, documentation, and test.
      git-push: Update documentation to describe the no-refspec behavior.

Junio C Hamano:
      format-patch: pretty-print timestamp correctly.
      detect broken alternates.
      pack-objects: reuse data from existing packs.
      pack-objects: finishing touches.
      git-repack: allow passing a couple of flags to pack-objects.
      pack-objects: avoid delta chains that are too long.
      Make "empty ident" error message a bit more helpful.
      Delay "empty ident" errors until they really matter.
      Keep Porcelainish from failing by broken ident after making changes.
      pack-objects eye-candy: finishing touches.
      git-fetch: follow tag only when tracking remote branch.

Nicolas Pitre:
      nicer eye candies for pack-objects
      also adds progress when actually writing a pack

