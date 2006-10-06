Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422729AbWJFXIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422729AbWJFXIb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 19:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422733AbWJFXIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 19:08:31 -0400
Received: from mail.impinj.com ([206.169.229.170]:33698 "EHLO earth.impinj.com")
	by vger.kernel.org with ESMTP id S1422729AbWJFXIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 19:08:30 -0400
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 5/5] fdtable: Extensive fs/file.c cleanups.
Date: Fri, 6 Oct 2006 16:08:29 -0700
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200610052152.29013.vlobanov@speakeasy.net> <200610061438.07702.vlobanov@speakeasy.net> <20061006154254.e9d584d0.akpm@osdl.org>
In-Reply-To: <20061006154254.e9d584d0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610061608.29085.vlobanov@speakeasy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 October 2006 15:42, Andrew Morton wrote:
> On Fri, 6 Oct 2006 14:38:07 -0700
>
> Vadim Lobanov <vlobanov@speakeasy.net> wrote:
> > This patch still has a lot of useful (and I'd argue necessary) fixes for
> > incorrect comments and confusing code ordering. It's especially nice for
> > those who might try to understand what's going on inside fs/file.c, so
> > seems a shame to drop it. I could...
> > 	... hold on to it until the other fdtable changes hit mainline.
> > 		or
> > 	... redo this one with just the bare essentials.
> > 		or
> > 	... drop it completely.
>
>                 or
>         ... redo the patches so this one comes first.
>
> Which sounds like a hassle.  If it's too much hassle, your option 1 sounds
> OK.

I'll hold on to it for now, then. It's probably best, so there's less 
code-churn, and the patches will hopefully get more technical reviews and 
testing.

In the future, I'll make sure to send cleanups first in the series. Thanks for 
the feedback. :)

-- Vadim Lobanov
