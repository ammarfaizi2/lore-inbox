Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbUC2J6H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 04:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbUC2J6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 04:58:07 -0500
Received: from mail.bytecamp.net ([212.204.60.9]:5905 "EHLO mail.bytecamp.net")
	by vger.kernel.org with ESMTP id S262135AbUC2J6E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 04:58:04 -0500
Message-Id: <200403290958.i2T9w2fJ029554@mail.bytecamp.net>
From: "Jan Kesten" <rwe.piller@the-hidden-realm.de>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.6.4 and nfs lockd.udpport?
Date: Mon, 29 Mar 2004 11:58:02 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all! 

I'm running a 2.6.4 kernel with compiled in nfs support. I have to tie the 
used ports because there is a firewall to gro through. mountd, statd and 
rquotad are just fine, I can change ports after booting, no problem. But not 
for lockd (or nlockmgr), since AFAIK this must be done with boot parameters. 

I read the docs and found that the parameters sould be lockd.udpport and 
lockd.tcpport=xxx - but this doesn't work. While booting I got errors that 
both are unknown boot options. 

Where is my mistake? 

Cheers,
Jan
