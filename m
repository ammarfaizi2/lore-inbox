Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbTKJQej (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 11:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263976AbTKJQej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 11:34:39 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:63156 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S263971AbTKJQeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 11:34:37 -0500
Message-Id: <200311101634.hAAGYVe4029811@faui31x.informatik.uni-erlangen.de>
Content-Type: text/plain; charset=US-ASCII
From: Peter Asemann <sipeasem@immd3.informatik.uni-erlangen.de>
To: linux-kernel@vger.kernel.org
Subject: Is there a kernel configuration option to disable the filling of struct siginfo member si_fd?
Date: Mon, 10 Nov 2003 17:34:31 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Be greeted!

I'm awfully sorry to bother... but I've got a question I nowhere found an 
answer to. So here it is:

In a previous mail to this list ( 
http://www.ussg.iu.edu/hypermail/linux/kernel/0307.1/1088.html ) I asked how 
to make use of the si_fd member of the struct siginfo in case I use the 
advanced form of a signal handler.
Thanks to the nice people who answered my request, I was able to write a 
program using the si_fd member in case it gets a SIGIO so it doesn't have to 
use select.

Now I found that some machines I have access to have custom 2.4 series 
kernels which do not fill in the si_fd member of the struct siginfo.
As it's perfectly possible that these custom 2.4 series kernels which also 
include some hacks are broken in some way, 
I'd like to know if there is a kernel configuration option to disable the 
functionality that the si_fd member of struct siginfo is filled in - so it 
was possible the guys who compiled the custom kernels just didn't select the 
appropriate options, so that'd be why the kernels don't work the way I'd like 
them to, and I can easily fix everything by recompiling the kernels with some 
extra option selected.

Or is there no such option, so the fact the si_fd member is not filled in 
definitely means that the custom kernels are broken, and the reason is that 
the people who built in the hacks did something wrong?

Thanks in advance,

Peter Asemann
