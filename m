Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbVAHWFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbVAHWFq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 17:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbVAHWFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 17:05:38 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:15123 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261943AbVAHWBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 17:01:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=HxomOzVkAW6pxpVkNc4tKivasKHEIflKTPq1lsZQHBldEQDkE4jel0CKK2kIgCHJhSRhD6B3y4fxt+FyBVrnzYvsy64RA7pvDsQ1loFtvHU818Yu15qVreIY+t5Y7XB+QvLqeBkes568Z0G+8DOmq8J7DQmTsBTIYdQggRRlFJ4=
Message-ID: <7f800d9f050108140116a8f2c3@mail.gmail.com>
Date: Sat, 8 Jan 2005 14:01:03 -0800
From: Andre Eisenbach <int2str@gmail.com>
Reply-To: Andre Eisenbach <int2str@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: X applications don't run with 2.6.10-mm2
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, all,

After updrading from linux-2.6.10-rc2-mm3 to linux-2.6.10-mm2, X
windows applications (any) would not start anymore. Not even Xterm.
The X server alone would run, but launching any application resulted
in this error message:

XIO: fatal IO error 25 (Inappropriate ioctl for device) on X server ":0.0"
after 118 requests (115 known processed) with 10 events remaining.

No error shows up in dmesg or the X server log.

According to a post on this site [1], the problem already occured with
2.6.10-rc3-mm1, which I personally didn't try.

I've since switched to linux-2.6.10-ck2 and it works without a problem.

Let me know if you would like me to do any more testing.

Hardware is a AMD 2400+ Notebook with Radeon Mobility (IGP 320) graphics card.

Cheers,
   Andre

---
[1] http://www.phaeronix.net/node/25
