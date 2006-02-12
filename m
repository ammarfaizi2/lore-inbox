Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbWBLTql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWBLTql (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 14:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWBLTqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 14:46:40 -0500
Received: from hera.kernel.org ([140.211.167.34]:24465 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751064AbWBLTqj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 14:46:39 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: netboot broken ?
Date: Sun, 12 Feb 2006 11:03:44 -0800 (PST)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <dso0qg$25j$1@terminus.zytor.com>
References: <43D9C8C5.3020902@t-online.de> <1138378138.4801.9.camel@obsidian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1139771024 2228 127.0.0.1 (12 Feb 2006 19:03:44 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Sun, 12 Feb 2006 19:03:44 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1138378138.4801.9.camel@obsidian>
By author:    "Bryan O'Sullivan" <bos@serpentine.com>
In newsgroup: linux.dev.kernel
>
> On Fri, 2006-01-27 at 08:16 +0100, Knut Petersen wrote:
> 
> > Any ideas? Can anybody please
> >  - confirm that network booting does still work
> >  - confirm that it is broken.
> 
> Network booting has been in limbo for years, and hasn't had a lick of
> maintenance in approximately forever.  The way forward is supposed to be
> via initramfs, but nobody is testing the nfsroot code in there, so it
> has a fair probability of not working.
> 

Feel free to pull the unified git repository and help test:

git://git.kernel.org/pub/scm/linux/kernel/git/hpa/linux-2.6-klibc.git

I really would appreciate both positive and negative bug reports.

	-hpa
