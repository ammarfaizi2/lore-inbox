Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267596AbUIBGCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267596AbUIBGCv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 02:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267602AbUIBGCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 02:02:50 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:6795 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267596AbUIBGCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 02:02:40 -0400
Subject: Re: excessive swapping
From: Florin Andrei <florin@andrei.myip.org>
Reply-To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
In-Reply-To: <1092379250.2597.14.camel@rivendell.home.local>
References: <1092379250.2597.14.camel@rivendell.home.local>
Content-Type: text/plain
Message-Id: <1094104952.4339.10.camel@rivendell.home.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 01 Sep 2004 23:02:32 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-12 at 23:40, Florin Andrei wrote:
> I am running 2.6.8-rc4 with Ingo's voluntary preempt patch O5, on Fedora
> 2.
> At the same time, i'm processing some DVDs that i made - i'm extracting
> titles from a DVD to a dedicated hard-drive, saving audio and video
> tracks, etc with transcode-0.6.12 ( http://www.transcoding.org ). All
> that means reading/writing from/to large files on /dev/dvd and /dev/hde
> at high speeds.
> The system is swapping excessively. There's no way the total size of the
> applications exceeds the size of RAM. There's plenty of room to spare,
> yet 16% of the 530MB of swap is used.

I am running now 2.6.8.1 with Ingo's O8 and Con Kolivas' hard swappiness
patch (an old version, sorry). Under the same conditions described
above, there is 0% swap usage.

The CK hard swappiness patch solved the issue for me. The system works
without any problems whatsoever.

-- 
Florin Andrei

http://florin.myip.org/

