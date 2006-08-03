Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWHCBV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWHCBV6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 21:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWHCBV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 21:21:58 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:483 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932121AbWHCBV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 21:21:58 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Willy Tarreau <w@1wt.eu>
Cc: mtosatti@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.33-rc3 needs to export memchr() for smbfs
Date: Thu, 03 Aug 2006 11:21:51 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <27i2d214opklm6aa6hglfo1c45sp45cmf0@4ax.com>
References: <20060802214608.GA1987@1wt.eu>
In-Reply-To: <20060802214608.GA1987@1wt.eu>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2006 23:46:08 +0200, Willy Tarreau <w@1wt.eu> wrote:

>Hi Marcelo,
>
>just finished building 2.4.33-rc3 on my dual-CPU Sun U60 (works
>fine BTW). I noticed that smbfs built as a module needs memchr()
>since a recent fix, so this one now needs to be exported, which
>this patch does.  Sources show that the lp driver would need it
>too is console on LP is enabled and LP is set as a module (which
>seems stupid to me anyway). I've pushed it into -upstream if you
>prefer to pull from it.
>
>Overall, 2.4.33-rc3 seems to be OK to me. I don't think that
>an additionnal -rc4 would be needed just for this export (Grant
>CCed in case he's wishing to do a few more builds, you know
>him...  :-) ).

Just one build, deltree server 'cos it exports some shares to 'doze 
boxen.  Seems to be okay without the patch but...

Makes no difference to my limited usage here.  Didn't break ;)
<http://bugsplatter.mine.nu/test/boxen/deltree/> *-rc3a

uptime 21 mins...

Cheers,
Grant.
