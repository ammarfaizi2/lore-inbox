Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266519AbUG0TxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266519AbUG0TxX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 15:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266520AbUG0TxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 15:53:18 -0400
Received: from mail.tmr.com ([216.238.38.203]:268 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S266519AbUG0TxL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 15:53:11 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH] Delete cryptoloop
Date: Tue, 27 Jul 2004 15:56:05 -0400
Organization: TMR Associates, Inc
Message-ID: <ce6bgq$hvt$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com><Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com> <1090672906.8587.66.camel@ghanima>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1090957659 18429 192.168.12.100 (27 Jul 2004 19:47:39 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
In-Reply-To: <1090672906.8587.66.camel@ghanima>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fruhwirth Clemens wrote:

> However, I do recommend that cryptoloop is removed from the kernel || is
> declared deprecated for the following reasons:
> 
> - There is no suitable user space tool ready to use it. util-linux has
> been broken ever since. My patch key-trunc-fix patch has to be applied
> to make any use of losetup. Further I'm not going to submit patches to
> this project to fix user space problems (see below)

Users can mount if you allow it fstab, what tool did you have in mind? 
And AFAIK dm-crypt will not work on a file without workarounds which are 
unknown to mount.
> 
> - I'm not going to submit patches to cure the security problems of
> cryptoloop pointed out in the first few paragraphs,
> 
> - dm-crypt is a stable alternative and can be easily immigrated to with
> the help of my little lotracker tool:
> http://clemens.endorphin.org/lo-tracker

Does it work on files with mount? Until the answer is YES it means that 
it requires new tools being installed and user/admin training. Not all 
Linux systems are used by developers!
> 
> So much for cryptoloop.


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
