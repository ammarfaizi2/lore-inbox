Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbWHCOuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbWHCOuz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 10:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbWHCOuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 10:50:54 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:38586 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932491AbWHCOuy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 10:50:54 -0400
Subject: Re: Next 2.6.17-stable review cycle will be starting in about 24
	hours
From: Marcel Holtmann <marcel@holtmann.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060803074850.GA28301@kroah.com>
References: <20060803074850.GA28301@kroah.com>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 18:47:32 +0200
Message-Id: <1154623652.3905.76.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> This is a heads up that the next 2.6.17-stable review cycle will be
> starting in about 24 hours.  I've caught up on all pending -stable
> patches that I know about and placed them in our queue, which can be
> browsed online at:
> 	http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=tree;f=queue-2.6.17
> 
> If anyone sees that this queue is missing something that they feel
> should get into the next 2.6.17-stable release, please let us know at
> stable@kernel.org within the next 24 hours or so.

instead of ext3-avoid-triggering-ext3_error-on-bad-nfs-file-handle.patch
it makes more sense to include the revised patches from Neil:

http://comments.gmane.org/gmane.linux.kernel/430323

It seems that these are not merged upstream, but my understanding was
that they were the best way to fix this. For RHEL4 we are going with
these two patches. 

Linus, any reason why they are not merged yet?

Regards

Marcel


