Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbUCIASZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 19:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbUCIASZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 19:18:25 -0500
Received: from hera.kernel.org ([63.209.29.2]:26511 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261419AbUCIASV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 19:18:21 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: HELP: Linux replacement for "DOS diagnostic" station
Date: Tue, 9 Mar 2004 00:18:10 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c2j2g2$298$1@terminus.zytor.com>
References: <404CFF03.1090601@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1078791490 2345 63.209.29.3 (9 Mar 2004 00:18:10 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 9 Mar 2004 00:18:10 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <404CFF03.1090601@techsource.com>
By author:    Timothy Miller <miller@techsource.com>
In newsgroup: linux.dev.kernel
> 
> So, first of all, we need to make /dev/mem accessible to all users. 
> Secondly, we need some mechanism to access I/O and config space, but it 
> can be indirect through ioctl.
> 
> Is there a driver for Linux which supports I/O and config space access 
> for user-space programs in a completely generic way?
> 

Just use iopl(3) and do the accesses directly from userspace, or use
/dev/port.

	-hpa
