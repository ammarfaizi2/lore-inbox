Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262924AbSLKFa6>; Wed, 11 Dec 2002 00:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263256AbSLKFa6>; Wed, 11 Dec 2002 00:30:58 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:41999
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262924AbSLKFa6>; Wed, 11 Dec 2002 00:30:58 -0500
Subject: Re:  Problem with mm1 patch for 2.5.51
From: Robert Love <rml@tech9.net>
To: Con Kolivas <conman@kolivas.net>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
In-Reply-To: <1039583335.3df6c8677cff4@kolivas.net>
References: <1039583335.3df6c8677cff4@kolivas.net>
Content-Type: text/plain
Organization: 
Message-Id: <1039585128.4382.0.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 11 Dec 2002 00:38:48 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-11 at 00:08, Con Kolivas wrote:

> I suspect I suffered a similar fate with the osdl test box. While I was away
> letting it run a benchmark in smp mode the filesystem had remounted read only. I
> tried rebooting to make some sense of what had happened but was unable to start
> the machine with any kernel. I've asked the osdl people to have a look at the
> box for me.
> 
> Previously a run in uniprocessor mode ran flawlessly.

This looks like a fix to the ext3 bug I posted last week, which was on
UP.

It comes and goes... I am in 2.5-mm with no problems now, but it was
killing me last week.  *shrug*

Here's to hoping this fixes it...

	Robert Love

