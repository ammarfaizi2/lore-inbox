Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264235AbTKKDK7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 22:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264237AbTKKDK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 22:10:59 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:17054 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264235AbTKKDK6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 22:10:58 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 10 Nov 2003 19:10:09 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Andrea Arcangeli <andrea@suse.de>, Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
In-Reply-To: <3FAFEA34.7090005@zytor.com>
Message-ID: <Pine.LNX.4.44.0311101908540.2097-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Nov 2003, H. Peter Anvin wrote:

> I guess the "best" solution is to use LVM atomic snapshots, and only
> allow rsync off the atomic snapshot.  That way any particular rsync
> session would always be consistent.  That's a *HUGE* amount of work,
> though, and still doesn't solve the mirrors issue -- I don't control
> what the mirrors run.  On the other hand, I don't know how many mirror
> sites actually mirror /pub/scm since it's not a requirement.

BTW, is rsync.kernel.org::pub/scm/linux/kernel/bkcvs currently being fed 
with new data? I don't get any updates.



- Davide


