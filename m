Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263956AbUKZUUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263956AbUKZUUv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 15:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264058AbUKZUTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 15:19:47 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:61091 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263962AbUKZT4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:56:51 -0500
Subject: Re: Suspend 2 merge: 18/51: Debug page_alloc support.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041125182140.GH1417@openzaurus.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101295326.5805.259.camel@desktop.cunninghams>
	 <20041125182140.GH1417@openzaurus.ucw.cz>
Content-Type: text/plain
Message-Id: <1101420382.27250.60.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 26 Nov 2004 09:06:22 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-11-26 at 05:21, Pavel Machek wrote:
> Hi!
> 
> > This patch provides support for making suspend work when DEBUG_PAGEALLOC
> > is enabled.
> 
> Is swsusp1 broken in this config?

I'd be surprised if it wasn't. You need to map pages in (and unmap them)
to do the copy/restore.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

