Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWBFVbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWBFVbT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 16:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWBFVbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 16:31:19 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:53660 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932138AbWBFVbS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 16:31:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iZ6TP6OTVi21TjyJVBcj0R0ttMcRm2lwYDQBnih3vepE0QHLGx9Jyate5QqXkSwAECAVvQnQy0i6e2HIeGjSGG5CWCQpLmAm+r3c2zuFVyPxGF94UJurhS+/0NfozE1PqpvdnOtIYRdEdOPoll+/5tM65XfpLQ04m3+ZRgMaISc=
Message-ID: <12c511ca0602061331p545deb80h4b818b23f097133e@mail.gmail.com>
Date: Mon, 6 Feb 2006 13:31:17 -0800
From: Tony Luck <tony.luck@gmail.com>
To: Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH 1/3] NEW VERSION: *at syscalls: Implementation
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       kenneth.w.chen@intel.com
In-Reply-To: <12c511ca0602061226pf3bf095jcc570754656c5437@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200512171742.jBHHgAKh018491@devserv.devel.redhat.com>
	 <12c511ca0602061226pf3bf095jcc570754656c5437@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore the rest of this too :-(
> long sys_mkdirat(int dfd, const char *pathname, int mode)
> {
>         return syscall(__NR_mknodat, dfd, pathname, mode);
                                         ^^^^^^^^
> }

Blame it on pre-lunch low blood sugar.

-Tony
