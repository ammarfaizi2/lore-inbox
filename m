Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264512AbUENCW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264512AbUENCW7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 22:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264762AbUENCW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 22:22:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:20366 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264512AbUENCW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 22:22:58 -0400
Date: Thu, 13 May 2004 19:22:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andy Isaacson <adi@bitmover.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 1352 NUL bytes at the end of a page?
Message-Id: <20040513192231.73064709.akpm@osdl.org>
In-Reply-To: <20040513190833.GH17965@bitmover.com>
References: <20040513190833.GH17965@bitmover.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Isaacson <adi@bitmover.com> wrote:
>
>  We've got a user who's reporting BK problems which we've traced down to
>  the fact that his s.ChangeSet file has a hole, filled with '\0' bytes,
>  that's so far always 1352 bytes long, and the end is page-aligned.  (In
>  fact, the two cases we've seen so far have been 8k-aligned.)  The
>  correct file data picks up again after the hole.

When the reporter has a PIII machine it's often useful to find out the clock
frequency - the lower it is, the older it is and the more likely it is that
some component has rotted.

If this one cannot be reproduced on any other machine I'd say it's a
hardware failure.
