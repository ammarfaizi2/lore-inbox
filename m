Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265065AbTLHRYN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 12:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265059AbTLHRYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 12:24:13 -0500
Received: from scrat.hensema.net ([62.212.82.150]:15077 "EHLO
	scrat.hensema.net") by vger.kernel.org with ESMTP id S265065AbTLHRYK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 12:24:10 -0500
From: Erik Hensema <erik@hensema.net>
Subject: Re: incorrect inode count on reiserfs
Date: Mon, 8 Dec 2003 17:24:02 +0000 (UTC)
Message-ID: <slrnbt9cti.31m.erik@bender.home.hensema.net>
References: <3FD47BFC.9020008@scssoft.com> <16340.33245.887082.96412@laputa.namesys.com> <slrnbt9322.27h.erik@bender.home.hensema.net> <pan.2003.12.08.16.09.22.30237@smurf.noris.de>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.7.4 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Urlichs (smurf@smurf.noris.de) wrote:
> Hi, Erik Hensema wrote:
> 
>> But innwatch checks for a out-of-inodes condition. How can it differentiate
>> between a undefined number of inodes (field set to 0) and a system that ran
>> out of inodes (field dropped to 0)?
>> 
> Create a file. Watch that succeed. Check whether this succeeds, and that
> the number of free inodes is still zero.
> Delete the file. Check that the number of free inodes is _still_ zero.
> 
> Repeat a few times, with random sub-second delay if you're feeling
> especially paranoid today, for added confidence.

So what hack is uglier? ;-)

-- 
Erik Hensema <erik@hensema.net>
