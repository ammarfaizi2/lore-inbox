Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265298AbUBISKl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 13:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265311AbUBISKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 13:10:41 -0500
Received: from kiuru.kpnet.fi ([193.184.122.21]:19362 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S265298AbUBISKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 13:10:40 -0500
Subject: [2.6.3-rc1] ide-scsi burning broken
From: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
To: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1076350237.844.3.camel@midux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 09 Feb 2004 20:10:37 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,
I was going to burn a cd earlier today, and I noticed it wont work in
2.6.3-rc1, k3b (the burning software) just freezed in 'D' state, and
after a moment I got something like this in my dmesg:
/dec/sr0 drive not ready!
/dec/sr0 drive not ready!
/dec/sr0 drive not ready!
[x1000]
So I guess the ide-scsi patches broke up things.

The burning in 2.6.1-mm4 works fine.

I know I should use ide-cd whatever, but I've always done it with
ide-scsi and I wont easily change that.

        Markus

