Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262990AbVCDS7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262990AbVCDS7a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 13:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262987AbVCDS4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 13:56:17 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:34798 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262964AbVCDSyb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 13:54:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Cz2wTgrBH4YDcgUu5jBhjqmHzR1R/b/mcO8vsZEDT4oDGqTpbPbUPScFwKdFSE+pEKNeThteB2QL8ejBa2VaqcKYLQtLt+jRtMdgg1XH1N+YeYy3nhVniOd+BizZfm09XiZZmo5lFuo04gLzKBre+ZGG+MyM3OilMr0W0ebDVgk=
Message-ID: <d91f4d0c050304105339eb297d@mail.gmail.com>
Date: Fri, 4 Mar 2005 13:53:50 -0500
From: George Georgalis <georgalis@gmail.com>
Reply-To: George Georgalis <georgalis@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: problem with linux 2.6.11 and sa
In-Reply-To: <20050304043706.GA10336@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050303184605.GB1061@ixeon.local>
	 <d91f4d0c0503031057306a74e1@mail.gmail.com>
	 <20050304043706.GA10336@havoc.gtf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2005 23:37:06 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> On Thu, Mar 03, 2005 at 01:57:28PM -0500, George Georgalis wrote:
> > I recall a problem a while back with a pipe from
> > /proc/kmsg that was sent by root to a program with a
> > user uid. The fix was to run the logging program as
> > root. Has that protected pipe method been extended
> > since 2.6.8.1?
> >
> > I'm very defiantly seeing a problem with the 2.6.11
> > kernel and my spamassassin setup. However, it's not
> > clear exactly where the problem is, seems like sa
> > but it might be 2.6.11 with daemontools + qmail +
> > QMAIL_QUEUE.
> 
> Does reverting to 2.6.10 fix this behavior?

Yes, actually I revert to 2.6.8.1; will try 2.6.10 today...

// George

-- 
George Georgalis, systems architect, administrator Linux BSD IXOYE
http://galis.org/george/ cell:646-331-2027 mailto:george@galis.org
