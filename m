Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263506AbTKCXzM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 18:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263513AbTKCXzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 18:55:12 -0500
Received: from 64-60-75-69.cust.telepacific.net ([64.60.75.69]:64012 "EHLO
	racerx.ixiacom.com") by vger.kernel.org with ESMTP id S263506AbTKCXzK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 18:55:10 -0500
Message-ID: <3FA6F628.70305@ixiacom.com>
Date: Mon, 03 Nov 2003 16:43:20 -0800
From: Dan Kegel <dkegel@ixiacom.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030617
X-Accept-Language: en
MIME-Version: 1.0
To: fleury@cs.auc.dk, linux-kernel <linux-kernel@vger.kernel.org>
Subject: allocating netlink families? (was: re: Announce: NetKeeper Firewall
 For Linux)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Emmanuel Fleury wrote:
 >   http://www.cs.auc.dk/~fleury/netkeeper/

Hey, that seems to be a nice example of how to write
a new netlink family.  Thanks!

I see you're using NETLINK_USERSOCK.  Netlink families
appear to be a precious commodity (netlink_dev.c, at
least, will break if you raise MAX_LINKS above 32).

Has there been any discussion of how one should pick
netlink family numbers for new stuff like netkeeper?
Sure, everyone could use NETLINK_USERSOCK, but
that means only one new netlink module could be resident at a time...
- Dan

