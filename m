Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbUCLIKg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 03:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbUCLIKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 03:10:36 -0500
Received: from hera.kernel.org ([63.209.29.2]:22403 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262028AbUCLIKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 03:10:35 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: /dev/root: which approach ? [PATCH]
Date: Fri, 12 Mar 2004 08:10:23 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c2rr9f$ppr$1@terminus.zytor.com>
References: <20040310162003.GA25688@cistron.nl> <404F77F3.9070106@kolumbus.fi> <c2nv6c$j5$2@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Trace: terminus.zytor.com 1079079023 26428 63.209.29.3 (12 Mar 2004 08:10:23 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 12 Mar 2004 08:10:23 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <c2nv6c$j5$2@news.cistron.nl>
By author:    "Miquel van Smoorenburg" <miquels@cistron.nl>
In newsgroup: linux.dev.kernel
>
> In article <404F77F3.9070106@kolumbus.fi>,
> Mika Penttilä  <mika.penttila@kolumbus.fi> wrote:
> >
> >>My question to the FS hackers: which one is the preferred approach?
> >>
> >>dev_root_alias.patch
> >>
> >>+	/* See if device is the /dev/root alias. */
> >>+	if (dev == MKDEV(4, 1)) {
> >
> >what is this 4,1, a tty???
> 
> If it was a character device, yes. But it's a block device, and
> major 4 isn't used yet. I just made it up, a major would need to
> be allocated by LANANA ofcourse.
> 

Please contact John Cagle <device@lanana.org>.

	-hpa
