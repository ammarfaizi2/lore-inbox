Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030256AbWA0BzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbWA0BzO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 20:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030257AbWA0BzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 20:55:14 -0500
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:40131 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1030256AbWA0BzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 20:55:12 -0500
From: Con Kolivas <kernel@kolivas.org>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: smp 'nice' bias support breaks scheduler behavior
Date: Fri, 27 Jan 2006 12:54:53 +1100
User-Agent: KMail/1.9
Cc: Peter Williams <pwil3058@bigpond.net.au>, mingo@elte.hu,
       nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
References: <20060126025220.B8521@unix-os.sc.intel.com> <200601271229.02752.kernel@kolivas.org> <20060126173423.B19789@unix-os.sc.intel.com>
In-Reply-To: <20060126173423.B19789@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601271254.54009.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 January 2006 12:34, Siddha, Suresh B wrote:
> On Fri, Jan 27, 2006 at 12:29:02PM +1100, Con Kolivas wrote:
> > We planned to push it for 2.6.16 but issues showed up, which Peter has
> > since addressed - but this means the code has not had enough testing to
> > go into 2.6.16 - so it is likely to be in 2.6.17.
>
> Then for 2.6.16, I would like to see smp nice handling patch backed out.
>
> Do you agree?

It's not my decision to keep Peter's patch out of mainline. If you can make a 
strong enough case for it then Linus will merge it up even though it's after 
rc1. Otherwise I'll let Ingo decide on whether to pull the current 
implementation or not - you're saying that with the one thing you described 
that misbehaves that it is doing more harm than fixing smp nice handling.

Con
