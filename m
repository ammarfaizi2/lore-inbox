Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263385AbTJQLBn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 07:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263386AbTJQLBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 07:01:43 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:55709 "EHLO slimnas.slim")
	by vger.kernel.org with ESMTP id S263385AbTJQLBm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 07:01:42 -0400
Subject: [2.6.0-test3,6,7] IDE 'enhanced mode' problems
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1066388412.1585.8.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-3) 
Date: Fri, 17 Oct 2003 13:00:12 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have various systems running 2.6.0-test kernels without problems so I
thought lets try 2.6.0-test7 on my main system again...I had run test3
without problems on this system but now all of a sudden it could not
boot 2.6.0-test3/6/7 normally. It would never pass through init
completely. It just stalled.

The only thing I changed since the last time I ran 2.6.0 successfully
was that I removed the SATA drive (I am running this on a Asus P4C800).
In the BIOS the IDE settings where still set to 'Enhanced mode'. The 2.4
kernel series doesn't seem to have a problem with it. I can't boot 2.6.0
with this setting on.

After changing the mode back to 'Compatible' I can run 2.6.0 properly
again.

Is this a bug in the IDE ICH5 code?

Cheers,

Jurgen

