Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261968AbVBAKeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbVBAKeX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 05:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbVBAKeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 05:34:23 -0500
Received: from [213.188.213.77] ([213.188.213.77]:31171 "EHLO
	server1.navynet.it") by vger.kernel.org with ESMTP id S261968AbVBAKeS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 05:34:18 -0500
From: "Massimo Cetra" <mcetra@navynet.it>
To: "'Catalin(ux aka Dino) BOIE'" <util@deuroconsult.ro>,
       <linux-kernel@vger.kernel.org>
Cc: <linux-ide@vger.kernel.org>
Subject: RE: Strange vmstat output. 2.6.10 Scheduler?
Date: Tue, 1 Feb 2005 11:34:33 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcUISCYcxFL+WygES/qXCtUDvuswnwAAIoTw
In-Reply-To: <Pine.LNX.4.62.0502011217320.26221@webhosting.rdsbv.ro>
Message-Id: <20050201103414.F195184008@server1.navynet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> It seems strange because iowait is at 90% but nothing is 
> trasnfered to/from disk. Why is that?
> 
> I run postgresql on this server and I'm not satistied by it's speed.
> 
> Single Pentium IV, IDE disk.
> 
> What can be the problem?


I have noticed it several months ago.
Maybe this thread could be useful for you.
http://www.ussg.iu.edu/hypermail/linux/kernel/0408.2/1758.html

According to my tests, 2.4 with -lck still performs better than 2.6, so I
use 2.4 on production DB servers with any DB.

Massimo 

