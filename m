Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262826AbUCJUyR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 15:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262835AbUCJUxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 15:53:06 -0500
Received: from uucp.cistron.nl ([62.216.30.38]:24813 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S262829AbUCJUw3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 15:52:29 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: /dev/root: which approach ? [PATCH]
Date: Wed, 10 Mar 2004 20:52:28 +0000 (UTC)
Organization: Cistron Group
Message-ID: <c2nv6c$j5$2@news.cistron.nl>
References: <20040310162003.GA25688@cistron.nl> <404F77F3.9070106@kolumbus.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
X-Trace: ncc1701.cistron.net 1078951948 613 62.216.29.200 (10 Mar 2004 20:52:28 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <404F77F3.9070106@kolumbus.fi>,
Mika Penttilä  <mika.penttila@kolumbus.fi> wrote:
>
>>My question to the FS hackers: which one is the preferred approach?
>>
>>dev_root_alias.patch
>>
>>+	/* See if device is the /dev/root alias. */
>>+	if (dev == MKDEV(4, 1)) {
>
>what is this 4,1, a tty???

If it was a character device, yes. But it's a block device, and
major 4 isn't used yet. I just made it up, a major would need to
be allocated by LANANA ofcourse.

Mike.

