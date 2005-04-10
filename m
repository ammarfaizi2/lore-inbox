Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbVDJHwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVDJHwD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 03:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVDJHwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 03:52:03 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:19672 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261438AbVDJHwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 03:52:01 -0400
To: Linus Torvalds <torvalds@osdl.org>
cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: more git updates..
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
	<20050409200709.GC3451@pasky.ji.cz>
	<Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
From: Junio C Hamano <junkio@cox.net>
Date: Sun, 10 Apr 2005 00:51:59 -0700
In-Reply-To: <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> (Linus
 Torvalds's message of "Sat, 9 Apr 2005 14:00:09 -0700 (PDT)")
Message-ID: <7vhdifcbmo.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Listing the file paths and their sigs included in a tree to make
a snapshot of a tree state sounds fine, and diffing two trees by
looking at the sigs between two such files sounds fine as well.

But I am wondering what your plans are to handle renames---or
does git already represent them?

