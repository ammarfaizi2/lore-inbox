Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279065AbRJVXBV>; Mon, 22 Oct 2001 19:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279051AbRJVW6m>; Mon, 22 Oct 2001 18:58:42 -0400
Received: from zero.tech9.net ([209.61.188.187]:41226 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S279053AbRJVW6X>;
	Mon, 22 Oct 2001 18:58:23 -0400
Subject: Re: 2.4.12 w/ preempt patch
From: Robert Love <rml@tech9.net>
To: steve <sdroemen@home.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1003790595.3536.9.camel@lws01>
In-Reply-To: <1003790595.3536.9.camel@lws01>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.18.15.19 (Preview Release)
Date: 22 Oct 2001 18:58:59 -0400
Message-Id: <1003791539.1712.50.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-10-22 at 18:43, steve wrote:
> I got a bug error in my syslog  My machine had been running about 1 day.
> it is the 2.4.12 kernel with the preempt-kernel-rml-2.4.12-1.patch 
> patch from http://www.tech9.net/rml/linux
> 
> anybody know what went wrong, and how to fix it?

First, get the most recent patch.  revision -3 is out now at
http://tech9.net/rml/linux

Try this.  Even better, try the 2.4.13-pre6 patch against that kernel. 
Either way, a possible race was fixed in the newer versions.

If you still have an oops, try to reproduce it without any binary
modules loaded.

	Robert Love

