Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267864AbTGTTca (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 15:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267981AbTGTTc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 15:32:29 -0400
Received: from zork.zork.net ([64.81.246.102]:59617 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S267864AbTGTTc0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 15:32:26 -0400
To: James Morris <jmorris@intercode.com.au>
Cc: netdev@oss.sgi.com, <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.0-test1-mm1] TCP connections over ipsec hang after a few
 seconds
References: <Mutt.LNX.4.44.0307210116070.24197-100000@excalibur.intercode.com.au>
	<6uwued6lzv.fsf@zork.zork.net>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: James Morris <jmorris@intercode.com.au>,
 netdev@oss.sgi.com,  <linux-kernel@vger.kernel.org>
Date: Sun, 20 Jul 2003 20:47:17 +0100
In-Reply-To: <6uwued6lzv.fsf@zork.zork.net> (Sean Neakums's message of "Sun,
 20 Jul 2003 20:23:16 +0100")
Message-ID: <6usmp16kvu.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Neakums <sneakums@zork.net> writes:

> I ended up with about forty megabytes of tcpdump output on each side
> of the link before the hang occurred.  I've appended below the last
> 150 lines of each dump.  Four separate TCP connections were involved
> in all, for a total of about 400MiB of data transferred.

That is to say: the tree of files I was rsyncing is about 125MiB, and
I deleted the destination tree and repeated the transfer until I
reproduced the hang.

