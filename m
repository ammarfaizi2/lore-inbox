Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbWBXSQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbWBXSQV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 13:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbWBXSQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 13:16:20 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:18369 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932412AbWBXSQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 13:16:20 -0500
Message-ID: <43FF4CC2.3BEED999@tv-sign.ru>
Date: Fri, 24 Feb 2006 21:13:22 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paulmck@us.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 3/4] cleanup __exit_signal()
References: <43F9E873.808CD086@tv-sign.ru> <20060224180154.GB1735@us.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" wrote:
> 
> On Mon, Feb 20, 2006 at 07:04:03PM +0300, Oleg Nesterov wrote:
> > This patch factors out duplicated code under 'if' branches.
> > Also, BUG_ON() conversions and whitespace cleanups.
> 
> Passed steamroller.  Looks sane to me.

Oh, thanks!

I forgot to say it, but I had run steamroller tests too before I
sent "some tasklist_lock removals" series.

Do you know any other test which may be useful too?

Oleg.
