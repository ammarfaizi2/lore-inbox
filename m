Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276328AbRI1Vzc>; Fri, 28 Sep 2001 17:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276330AbRI1VzW>; Fri, 28 Sep 2001 17:55:22 -0400
Received: from [194.213.32.137] ([194.213.32.137]:5380 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S276328AbRI1VzQ>;
	Fri, 28 Sep 2001 17:55:16 -0400
Message-ID: <20010928234708.A1294@bug.ucw.cz>
Date: Fri, 28 Sep 2001 23:47:08 +0200
From: Pavel Machek <pavel@suse.cz>
To: detlefc@users.sourceforge.net,
        ACPI mailing list <acpi@phobos.fachschaften.tu-muenchen.de>,
        kernel list <linux-kernel@vger.kernel.org>, seasons@falcon.sch.bme.hu
Subject: [patch] swsusp/mini for 2.4.10
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Here's minimal version of swsusp, for 2.4.10. make -j 5 bzImage,
startx, suspend. When it boots, suspend again, and when that boots,
suspend again. Now it resumed, and I still can write this email. That
looks good.

								Pavel
PS: Gabor, this might be good candidate to put on webpage
somewhere. (But beware, I stripped everything non-essential out).

PPS: Alan, would you consider putting this to -ac somewhere?
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
