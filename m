Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265436AbUAKRcj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 12:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265468AbUAKRcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 12:32:39 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:35491 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265436AbUAKRci
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 12:32:38 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 11 Jan 2004 09:32:42 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Der Herr Hofrat <der.herr@hofr.at>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 schedule_tick question
In-Reply-To: <200401101722.i0AHM3l17594@hofr.at>
Message-ID: <Pine.LNX.4.44.0401110930220.19685-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jan 2004, Der Herr Hofrat wrote:

> > Yes, we could have a rotate_task() function but the impact is basically 
> > zero because of the little overhead compared to the frequency of the 
> > operation.
> >
> ok - well maby someone wants to drop it in any way as its
> trivial and actually it would be easier to read if the function name
> were rotate_task and not dequeue/enqueu to implement RR behavior.

Try to push a patch to Ingo. We already had a move_last_runqueue() in 2.4, 
but since now we have names like xxxx_task(), I believe rotate_task() 
sounds better.



- Davide


