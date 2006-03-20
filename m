Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWCTTcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWCTTcg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 14:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWCTTcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 14:32:36 -0500
Received: from users.ccur.com ([66.10.65.2]:61565 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S1751249AbWCTTcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 14:32:35 -0500
Date: Mon, 20 Mar 2006 14:32:20 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.16
Message-ID: <20060320193220.GA18472@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <Pine.LNX.4.64.0603192216450.3622@g5.osdl.org> <20060320171905.GA4228@tsunami.ccur.com> <441EFCB0.6020007@garzik.org> <Pine.LNX.4.61.0603202022590.3457@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0603202022590.3457@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 08:25:21PM +0100, Jan Engelhardt wrote:
> >
> > strace should be using sanitized versions of the kernel headers, not directly
> > including them verbatim...
> >
> Now, would not it be good for everyone if the in-kernel headers get
> every bit of sanitation? Especially those who are stuck with outdated 
> versions of sanitized headers (thinking of FC3 and FC4) often do the
> magic symlinking (/usr/include/linux -> /usr/src/linux/include/linux).

Also, if the policy is that only kernel code can reference the kernel
headers, this intent should be more strongly enforced by removing all
occurances of #ifdef __KERNEL__ in said headers.

Joe
