Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbTKKHrd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 02:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264275AbTKKHrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 02:47:33 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:61315 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264272AbTKKHrb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 02:47:31 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 10 Nov 2003 23:47:30 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Nick Piggin <piggin@cyberone.com.au>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
In-Reply-To: <3FB091C0.9050009@cyberone.com.au>
Message-ID: <Pine.LNX.4.44.0311102342550.980-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Nov 2003, Nick Piggin wrote:

> What happens if the the tree is updated while the client is fetching it?

Surprise, it breaks :-) Yes, the double file approach is needed (excluding 
changes to rsync).



- Davide


