Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262529AbVCVCmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbVCVCmP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbVCVClg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:41:36 -0500
Received: from fire.osdl.org ([65.172.181.4]:52379 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262208AbVCVBxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:53:10 -0500
Date: Mon, 21 Mar 2005 17:52:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org, len.brown@intel.com
Subject: Re: 2.6.12-rc1-mm1: Kernel BUG at pci:389
Message-Id: <20050321175232.34d93a13.akpm@osdl.org>
In-Reply-To: <20050322013535.GA1421@elf.ucw.cz>
References: <20050321025159.1cabd62e.akpm@osdl.org>
	<200503212343.31665.rjw@sisk.pl>
	<20050321160306.2f7221ec.akpm@osdl.org>
	<20050322004456.GB1372@elf.ucw.cz>
	<20050321170623.4eabc7f8.akpm@osdl.org>
	<20050322013535.GA1421@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> > Could I suggest that you prepare a fixup against 2.6.12-rc1-mm1 and send
>  > that to Len and myself?  If that fixup is not suitable for a 2.6.12-rc1
>  > based tree then I can look after it until things get flushed out.
> 
>  Could you just revert those two patches? First one is very
>  wrong. Second one might be fixed, but... See comments below.

I could revert them locally, but that wouldn't gain us much.

Greg hasn't taken the pm_message_t patches yet.  Perhaps that's for the best.

Perhaps I should just jam everything-from-Pavel into Linus's tree as soon
as he returns and then we can fix up the downstream fallout in the various
bk trees?
