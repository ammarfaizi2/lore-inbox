Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268540AbUHRBed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268540AbUHRBed (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 21:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268541AbUHRBed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 21:34:33 -0400
Received: from mail12.intermedia.net ([206.40.48.197]:56270 "HELO
	mail12.intermedia.net") by vger.kernel.org with SMTP
	id S268540AbUHRBe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 21:34:28 -0400
Date: Tue, 17 Aug 2004 18:46:20 -0700
From: Ranjeet Shetye <ranjeet.shetye2@zultys.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.8 / 2.6.8.1 flaky for e1000 networking
Message-ID: <20040818014620.GA8142@ranjeet-pc2.zultys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following kernels seem flaky w.r.t their e1000 network behaviour
linux-2.6.8
linux-2.6.8.1
linux-2.6.8.1-mm1
(linux-2.6.8-gentoo)

No modules loaded.

All these kernels seem to download at 10-15 kBytes/sec and come to a
halt every 100 kBytes or so. Then I have to restart the download manually
or use "wget -c -T 1" to force quick auto-restarts for downloads. The
hardware doesn't die, just seems to give up temporarily and restarting
the process seems to restart the download over the NIC without any issues.

There's no NFS traffic at all in my switched environment, so I dont think
that's a issue with the 2.6.8 kernels.

I am using a Dell GX260, 2.0 GHz P4 with i810fb, e1000. Gentoo Linux 2004.2

linux-2.6.7 and linux-2.6.7-ck5 are very stable i.e. 150 kBytes/sec download
speeds.

I am not subscribed to the mailing list so I dont really know if you guys
have already addressed this issue. A brief googling didn't reveal a solution.

Anyways, let me know if you need additional info.

thanks,

-- 
Ranjeet Shetye
Senior Software Engineer
Zultys Technologies
Ranjeet dot Shetye at Zultys dot com
http://www.zultys.com/
 
The views, opinions, and judgements expressed in this message are solely those of
the author. The message contents have not been reviewed or approved by Zultys.

