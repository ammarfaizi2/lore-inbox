Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbTKDSJv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 13:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbTKDSJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 13:09:51 -0500
Received: from [193.112.238.6] ([193.112.238.6]:26031 "EHLO caveman.xisl.com")
	by vger.kernel.org with ESMTP id S262464AbTKDSJu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 13:09:50 -0500
From: John M Collins <jmc@xisl.com>
Organization: Xi Software Ltd
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Semaphores and threads anomaly and bug?
Date: Tue, 4 Nov 2003 18:09:28 +0000
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0311040928110.20373-100000@home.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0311040928110.20373-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311041809.28543.jmc@xisl.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 November 2003 17:29, Linus Torvalds wrote:
> On Tue, 4 Nov 2003, John M Collins wrote:
> > I know this isn't defined anywhere but the seems to be an ambiguity and
> > discrepancy between versions of Unix and Linux over threads and
> > semaphores.
> >
> > Do the "SEM_UNDO"s get applied when a thread terminates or when the
> > "whole thing" terminates?
>
> It's entirely up to you. That's what CLONE_SYSVSEM is supposed to
> determine.
>
> However, CLONE_SYSVSEM is fairly recent, and I think you will need to use
> the new threading libraries to see it.

Thanks.

Could I possibly draw your attention to the other point I made about the 
updating of "sempid" which does seem to be a mistake to me?

-- 
John Collins Xi Software Ltd www.xisl.com
