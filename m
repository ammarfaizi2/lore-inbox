Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270622AbTHETsk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 15:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270623AbTHETsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 15:48:40 -0400
Received: from hera.cwi.nl ([192.16.191.8]:41721 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S270622AbTHETsd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 15:48:33 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 5 Aug 2003 21:48:29 +0200 (MEST)
Message-Id: <UTC200308051948.h75JmTA20097.aeb@smtp.cwi.nl>
To: adilger@clusterfs.com, akpm@osdl.org
Subject: Re: i_blksize
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I am not aware of anybody who actually uses i_blksize
>> to give per-file advice.

> Actually, Lustre uses this

Hmm. Not in the sources I have. Probably too old.

> reiserfs

I think constant per filesystem. The variable reiserfs_default_io_size
is a global constant in reiserfs/super.c.

Andries

