Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267043AbRGXHlA>; Tue, 24 Jul 2001 03:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267048AbRGXHku>; Tue, 24 Jul 2001 03:40:50 -0400
Received: from [213.97.45.174] ([213.97.45.174]:2067 "EHLO pau.intranet.ct")
	by vger.kernel.org with ESMTP id <S267043AbRGXHks>;
	Tue, 24 Jul 2001 03:40:48 -0400
Date: Tue, 24 Jul 2001 09:40:46 +0200 (CEST)
From: Pau Aliagas <linux4u@wanadoo.es>
X-X-Sender: <pau@pau.intranet.ct>
To: <linux-kernel@vger.kernel.org>
Subject: tons of Z processes in 2.4.7
Message-ID: <Pine.LNX.4.33.0107240937420.3350-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Since 2.4.6-ac[45] and now in 2.4.7 I keep on getting processes in Z
state, mainly identd (spawned from an identd daemon) and galeon (the gnome
browser).

An strace to the process ends immediately with the following message:
# strace -p 3697
attach: ptrace(PTRACE_ATTACH, ...): Operation not permitted
It doesn't matter wheater I'm root or not.

I've had almost 300 Z processes only in galeon.

Any explanation? Any help to trace it?

Pau


