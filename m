Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266665AbTGGUEN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 16:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbTGGUEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 16:04:13 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:63248 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S266665AbTGGUEK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 16:04:10 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: epoll vs stdin/stdout
Date: Mon, 7 Jul 2003 20:18:45 +0000 (UTC)
Organization: Cistron Group
Message-ID: <beckj5$e2a$1@news.cistron.nl>
References: <20030707154823.GA8696@srv.foo21.com> <Pine.LNX.4.55.0307071153270.4704@bigblue.dev.mcafeelabs.com> <20030707194736.GF9328@srv.foo21.com> <20030707200315.GA10939@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1057609125 14410 62.216.29.200 (7 Jul 2003 20:18:45 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030707200315.GA10939@mail.jlokier.co.uk>,
Jamie Lokier  <jamie@shareable.org> wrote:
>Unfortunately I cannot think of a way for a process to know, in
>general, whether two fds that it is passed correspond to the same file
>*.  Well, apart from trying epoll on it and seeing what happens :/

fstat() and compare st_dev and st_ino

Mike.

