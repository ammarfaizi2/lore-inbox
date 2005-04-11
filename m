Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261796AbVDKN6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbVDKN6q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 09:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbVDKN6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 09:58:46 -0400
Received: from hera.kernel.org ([209.128.68.125]:27070 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261796AbVDKN6l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 09:58:41 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: more git updates..
Date: Mon, 11 Apr 2005 13:58:20 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <d3dvps$347$1@terminus.zytor.com>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050410065307.GC13853@64m.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1113227900 3208 127.0.0.1 (11 Apr 2005 13:58:20 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 11 Apr 2005 13:58:20 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20050410065307.GC13853@64m.dyndns.org>
By author:    Christopher Li <lkml@chrisli.org>
In newsgroup: linux.dev.kernel
> 
> There is one problem though. How about the SHA1 hash collision?
> Even the chance is very remote, you don't want to lose some data do due
> to "software" error. I think it is OK that no handle that
> case right now. On the other hand, it will be nice to detect that
> and give out a big error message if it really happens.
> 

If you're actually worried about it, it'd be better to just use a
different hash, like one of the SHA-2's (probably a better choice
anyway), instead of SHA-1.

	-hpa

