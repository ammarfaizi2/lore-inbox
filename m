Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264184AbTKKD5o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 22:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264215AbTKKD5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 22:57:44 -0500
Received: from www.mail15.com ([62.118.249.44]:3335 "EHLO www.mail15.com")
	by vger.kernel.org with ESMTP id S264184AbTKKD5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 22:57:43 -0500
Message-ID: <3FB05EDE.6090007@myrealbox.com>
Date: Mon, 10 Nov 2003 20:00:30 -0800
From: walt <wa1ter@myrealbox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20031025 Thunderbird/0.4a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: kernel.bkbits.net off the air
References: <fa.na6uip6.p2erhm@ifi.uio.no> <fa.dbkbts9.1k7ohhd@ifi.uio.no>
In-Reply-To: <fa.dbkbts9.1k7ohhd@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

>>On Mon, 10 Nov 2003, Andrea Arcangeli wrote:
> The best way to fix this isn't to add locking to rsync, but to add two
> files inside or outside the tree, each one is a sequence number, so you
> fetch file1 first, then you rsync and you fetch file2, then you compare
> them. If they're the same, your rsync copy is coherent. It's the same
> locking we introduced with vgettimeofday...

How is this different from writing one file named LOCK while updating
the tree?

I know this is a really basic question, but it also seems like a really
old problem which must have been solved multiple times by now.  Am I
really wrong about this?
