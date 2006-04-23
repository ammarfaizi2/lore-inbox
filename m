Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbWDWEXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbWDWEXj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 00:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWDWEXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 00:23:39 -0400
Received: from [212.33.185.76] ([212.33.185.76]:2827 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751069AbWDWEXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 00:23:39 -0400
From: Al Boldi <a1426z@gawab.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [FIX] ide-io: increase timeout value to allow for slave wakeup
Date: Sun, 23 Apr 2006 07:21:54 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200604222359.21652.a1426z@gawab.com> <20060422145819.503c8451.akpm@osdl.org>
In-Reply-To: <20060422145819.503c8451.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604230721.54550.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Al Boldi <a1426z@gawab.com> wrote:
> > During an STR resume cycle, the ide master disk times-out when there is
> > also a slave present (especially CD).  Increasing the timeout in ide-io
> > from 10,000 to 100,000 fixes this problem.
> >
> > Andrew, do I have to send a patch or can you take care of this
> > one-liner?
>
> Please see the thread "sata suspend resume ..." on this mailing list,
> starting Wed, 19 Apr.  It sounds like the same thing.

Yes, that's what prompted me to look into ide-io.
So, will the sata fix also fix ide-io?

Thanks!

--
Al

