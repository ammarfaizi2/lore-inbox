Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263591AbTLSULz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 15:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263592AbTLSULz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 15:11:55 -0500
Received: from port-212-202-159-243.reverse.qsc.de ([212.202.159.243]:15594
	"EHLO mail.onestepahead.de") by vger.kernel.org with ESMTP
	id S263591AbTLSULx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 15:11:53 -0500
Subject: 2.6 vs 2.4 regression when running gnomemeeting
From: Christian Meder <chris@onestepahead.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1071864709.1044.172.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 19 Dec 2003 21:11:50 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got a longstanding regression in gnomemeeting usage when switching
between 2.4 and 2.6 kernels.

Phenomenon: 
Without load gnomemeeting VOIP connections are fine. As soon as some
load like a kernel compile is put on the laptop the gnomemeeting audio
stream is cut to pieces and gets unintelligible . On 2.4.2x I don't get
even the slightest distortion in the audio stream under load. I played
around with different nice levels with no success. The problem persisted
during the whole 2.6.0-test series no matter whether I used -mm kernels
or pristine Linus kernels. Even when nicing the kernel compile to +19
the distortions start right away. I tried Nick Piggin's scheduler which
fared slightly better after changing the nice level of gnomemeeting to
-10 but it's still a far cry from the 2.4.2x feeling without any
fiddling with nice values.

Any hints where to start looking are greatly appreciated.



			Christian Meder

-- 
Christian Meder, email: chris@onestepahead.de
 
What's the railroad to me ?
I never go to see
Where it ends.
It fills a few hollows,
And makes banks for the swallows, 
It sets the sand a-blowing,
And the blackberries a-growing.
                      (Henry David Thoreau)
 




