Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264066AbTE0R4X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 13:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264071AbTE0R4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 13:56:23 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:27654 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264066AbTE0R4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 13:56:06 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: manish <manish@storadinc.com>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Date: Tue, 27 May 2003 20:04:49 +0200
User-Agent: KMail/1.5.2
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org,
       Christian Klose <christian.klose@freenet.de>,
       William Lee Irwin III <wli@holomorphy.com>
References: <3ED2DE86.2070406@storadinc.com> <3ED3A2AB.3030907@gmx.net> <3ED3A55E.8080807@storadinc.com>
In-Reply-To: <3ED3A55E.8080807@storadinc.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200305271954.11635.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 May 2003 19:50, manish wrote:

Hi Manish,

> It is not a system hang but the processes hang showing the same stack
> trace. This is certainly not a pause since the bonnie processes that
> were hung (or deadlocked) never completed after several hrs. The stack
> trace  was the same.
then you are hitting a different bug or a bug related to the issues Christian 
Klose and me and $tons of others were complaining.

The bug you are hitting might be the problem with "process stuck in D state" 
Andrea Arcangeli fixed, let me guess, over half a year ago or so.

In case you have a good mind to try to address your issue, you might want to 
try out the patch you can find here:

http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21rc2aa1/9980_fix-pausing-2

ALL: Anyone who has this kind of pauses/stops/mouse is dead/keyboard is dead/:
     speak _NOW_ please, doesn't matter who you are!

I've added Andrea into CC.

ciao, Marc


