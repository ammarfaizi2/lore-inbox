Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbVL0IrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbVL0IrS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 03:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbVL0IrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 03:47:18 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:58320 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932267AbVL0IrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 03:47:17 -0500
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] GIT 1.0.5
Date: Tue, 27 Dec 2005 00:47:14 -0800
Message-ID: <7v64pbc4fh.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a minor bugfix release.  There is one real fix by
Johannes that would help people who manage symlinks with git.

Starting from this one I won't be touching debian/ directory,
nor supplying pre-built Debian binaries anymore.
The official maintainer seems to be reasonably quick to package
up things.  The packaging procedure used there seems to be quite
different from what I have, so I'd like to avoid potential
confusion and reduce work by the official maintainer and myself.

Also I've enhanced the post-update hook of git.git repository to
automatically prepare preformatted documentation, which I'll
cover in a separate message.


