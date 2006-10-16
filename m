Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWJPO7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWJPO7G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 10:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWJPO7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 10:59:06 -0400
Received: from ns.suse.de ([195.135.220.2]:19866 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932108AbWJPO7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 10:59:03 -0400
From: Andi Kleen <ak@suse.de>
To: linux-kernel@vger.kernel.org
Subject: BUG dcache.c:613 during autofs unmounting in 2.6.19rc2
Date: Mon, 16 Oct 2006 16:58:58 +0200
User-Agent: KMail/1.9.3
Cc: linux-fsdevel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610161658.58288.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While unmounting autofs on shutdown my workstation got a dcache.c:613 BUG 
with 2.6.19rc2.

Only jpegs available unfortunately:

http://one.firstfloor.org/~andi/autofs-oops1.jpg
http://one.firstfloor.org/~andi/autofs-oops2.jpg

I think it was autofs3 instead of autofs4 - at least I got both compiled in.
The autofs user land was autofs-4.1.4 (-6 suse rpm) 

-Andi
