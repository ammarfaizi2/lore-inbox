Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263881AbUFNUbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263881AbUFNUbq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 16:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263995AbUFNUbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 16:31:46 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:31609 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S263881AbUFNUbm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 16:31:42 -0400
Date: Mon, 14 Jun 2004 22:40:29 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 0/5] kbuild
Message-ID: <20040614204029.GA15243@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew. Here follows a number of kbuild patches.

The first replaces kbuild-specify-default-target-during-configuration.patch

They have seen ligiht testing here, but on the other hand the do not touch
any critical part of kbuild.

Patches:

default kernel image:		Specify default target at config
				time rather then hardcode it.
				Only enabled for i386 for now.
move rpm to scripts/package: 	Move rpm support so we are ready for
				more package types
add deb-pkg target:		Pack kernel in debian format
make clean improved:		make clean removes a few more files
external module build doc:	Add documentation for building external modules


Above changes can be pulled from linux-sam.bkbits.net/kbuild:
bk pull bk://linux-sam.bkbits.net/kbuild
(Being updated as I type)

Patches follows as individual mails.

If anyone like to cook up a targz-pkg target please feel free.

	Sam
