Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263550AbTJBXnh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 19:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263552AbTJBXnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 19:43:37 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:51976 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S263550AbTJBXng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 19:43:36 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
Date: Thu, 2 Oct 2003 23:43:35 +0000 (UTC)
Organization: Cistron Group
Message-ID: <blid77$ijr$1@news.cistron.nl>
References: <Pine.LNX.4.44.0310010803530.23860-100000@home.osdl.org> <3F7B9CF9.4040706@redhat.com> <blgol5$vd0$1@news.cistron.nl> <20031002223550.GB13853@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1065138215 19067 62.216.29.200 (2 Oct 2003 23:43:35 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031002223550.GB13853@mail.shareable.org>,
Jamie Lokier  <jamie@shareable.org> wrote:
>Miquel van Smoorenburg wrote:
>> How about use /proc/self/task/self/fd/%d if /proc/self/task/self
>> exists, /proc/self/fd/%d otherwise ?
>
>/dev/stdin is a symbolic link to /proc/self/fd/0.
>
>open("/dev/stdin", O_RDONLY) should always work, if descriptor 0 is readable.
>
>Maybe you're saying /dev/stdin should be changed to link to
>/proc/self/task/self/fd/0?

You're right, that would not fly. Scrap that idea.

Mike.

