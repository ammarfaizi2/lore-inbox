Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262430AbTEIKGO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 06:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbTEIKGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 06:06:14 -0400
Received: from nmh.informatik.uni-bremen.de ([134.102.224.3]:27860 "EHLO
	nmh.informatik.uni-bremen.de") by vger.kernel.org with ESMTP
	id S262430AbTEIKGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 06:06:14 -0400
To: linux-kernel@vger.kernel.org
From: Moritz Muehlenhoff <jmm@Informatik.Uni-Bremen.DE>
Subject: Re: 2.5: ieee1394 still broken, vesafb still broken, ipv6 still broken
In-Reply-To: <20030507235104.GA12486@codeblau.de>
References: <20030507235104.GA12486@codeblau.de>
Date: Fri, 9 May 2003 12:18:47 +0200
Message-Id: <E19E4xj-0006QQ-00@regenbogen.informatik.uni-bremen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In stuga.ml.linux.kernel, you wrote:
>   ipv6 is still broken because running npush and then starting npoll on
>     another virtual terminal will hang the kernel hard instantaneously.

I can confirm that. I ran into the same problem so weeks ago, but lacked
the time for a proper bugreport. I just did so (#692), and instead of
writing a weepy 50-lines-rant you should have done the same.
