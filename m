Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVC0B5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVC0B5R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 20:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVC0B5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 20:57:17 -0500
Received: from hera.kernel.org ([209.128.68.125]:43174 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261386AbVC0B5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 20:57:14 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: Squashfs without ./..
Date: Sun, 27 Mar 2005 01:56:26 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <d253sa$4d5$1@terminus.zytor.com>
References: <Pine.LNX.4.61.0503221645560.25571@yvahk01.tjqt.qr> <3e74c9409b6e383b7b398fe919418d54@mac.com> <cce9e37e0503251948527d322b@mail.gmail.com> <Pine.LNX.4.61.0503261059430.28431@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1111888586 4518 127.0.0.1 (27 Mar 2005 01:56:26 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Sun, 27 Mar 2005 01:56:26 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.61.0503261059430.28431@yvahk01.tjqt.qr>
By author:    Jan Engelhardt <jengelh@linux01.gwdg.de>
In newsgroup: linux.dev.kernel
> 
> You are right. . and .. do not need to show up (even they have been the 
> "leaders" of ls -l ;-), Midnight Commander (`mc`) for example synthesizes ".." 
> nevertheless.
> 
> So - what about removing . and .. in readdir for all "standard harddisk 
> filesystems" (ext*,reiser*, [jx]fs)? I mean, one party always has to loose...
> 

Are you seriously suggesting changing our behaviour of all the
conventional filesystems to a non-Unix behaviour, to match cramfs and
squashfs?

	-hpa
