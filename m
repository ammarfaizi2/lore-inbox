Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWHRKSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWHRKSX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 06:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWHRKSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 06:18:22 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:8588 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751342AbWHRKSV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 06:18:21 -0400
Date: Fri, 18 Aug 2006 14:10:04 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Joe Jin <lkmaillist@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>
Subject: Re: [take10 1/2] kevent: Core files.
Message-ID: <20060818100959.GA27479@2ka.mipt.ru>
References: <11557316922047@2ka.mipt.ru> <11557316932803@2ka.mipt.ru> <215036450608180235l28836e3fpa2b529d7c0f69571@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <215036450608180235l28836e3fpa2b529d7c0f69571@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 18 Aug 2006 14:13:25 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 05:35:45PM +0800, Joe Jin (lkmaillist@gmail.com) wrote:
> >+static int __devinit kevent_user_init(void)
> >+{
> >+       int err = 0;
> >+
> >+       err = kevent_sys_init();
> >+       if (err)
> >+               panic("%s: failed to initialize kevent: err=%d.\n", err);
> 
> Here should be?
>                    panic("%s: failed to initialize kevent: err=%d\n",
> kevent_name, err);

The whole function does not exist in the latest patchset anymore.

-- 
	Evgeniy Polyakov
