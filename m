Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263975AbTJFEyZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 00:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263976AbTJFEyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 00:54:25 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:14340
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S263975AbTJFEyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 00:54:24 -0400
Date: Sun, 5 Oct 2003 21:54:24 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Ulrich Drepper <drepper@redhat.com>,
       Mikael Pettersson <mikpe@csd.uu.se>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
Message-ID: <20031006045424.GK1205@matchmail.com>
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Albert Cahalan <albert@users.sourceforge.net>,
	Ulrich Drepper <drepper@redhat.com>,
	Mikael Pettersson <mikpe@csd.uu.se>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1065139380.736.109.camel@cube> <Pine.LNX.4.44.0310021720510.7833-100000@home.osdl.org> <20031003025338.GA15089@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031003025338.GA15089@mail.shareable.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 03, 2003 at 03:53:38AM +0100, Jamie Lokier wrote:
> Alternatively you could make the task fd directories be symbolic
> links to the group leader fd directory.

Now this sounds good.  It also shows more information (and no need to follow
symlinks, so fuser/lsof can be fast).
