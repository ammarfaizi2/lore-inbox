Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbTFWRzb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 13:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266085AbTFWRzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 13:55:31 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:56472 "EHLO
	kleikamp.austin.ibm.com") by vger.kernel.org with ESMTP
	id S262593AbTFWRza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 13:55:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: evil@g-house.de, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at jfs_dmap.c:776
Date: Mon, 23 Jun 2003 13:09:35 -0500
User-Agent: KMail/1.4.3
References: <3EF721C0.9010801@g-house.de>
In-Reply-To: <3EF721C0.9010801@g-house.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200306231309.36133.shaggy@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

JFS is broken when the page size is greater than 4K, as is the case for 
Alpha.  This needs to be fixed, but I've put it off since I haven't had 
ready access to the right hardware, and I haven't had any success 
trying to boot a i386 kernel with a larger page size.  I'll try to find 
the time to work on this within the next couple weeks.

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

