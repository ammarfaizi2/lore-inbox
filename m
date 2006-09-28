Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031254AbWI1Dqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031254AbWI1Dqo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 23:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWI1Dqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 23:46:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16555 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751277AbWI1Dqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 23:46:44 -0400
Date: Wed, 27 Sep 2006 20:46:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@suse.de>
Cc: "J. Bruce Fields" <bfields@fieldses.org>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Greg Banks <gnb@melbourne.sgi.com>
Subject: Re: [NFS] [PATCH 008 of 11] knfsd: Prepare knfsd for support of
 rsize/wsize of up to 1MB, over TCP.
Message-Id: <20060927204632.97c8f7c2.akpm@osdl.org>
In-Reply-To: <17691.17511.884028.425714@cse.unsw.edu.au>
References: <20060824162917.3600.patches@notabene>
	<1060824063711.5008@suse.de>
	<20060925154316.GA17465@fieldses.org>
	<17691.17511.884028.425714@cse.unsw.edu.au>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006 13:41:27 +1000
Neil Brown <neilb@suse.de> wrote:

> 	pages = 2 + (size+ PAGE_SIZE -1) / PAGE_SIZE;

That's (the newly-added) DIV_ROUND_UP().
