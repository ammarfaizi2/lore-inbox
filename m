Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVFZBBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVFZBBh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 21:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbVFZBBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 21:01:37 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:33046 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261267AbVFZBBf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 21:01:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Qt93FTKGTz/0PPpxs758EMDmOopXPRUcQ2a52IpEwjfGkHKKObVqDFDdydu1OKNfJ6c71F3rHs11eacwRZI3cdo6tVBW03aD8oAZ2hvxAaNUO22epUWM1iRl54FMmubjmUr2mtrgPGtKTQtQsS5NXSwbYTX+l4D0ltLWcS/MBXA=
Message-ID: <cc27d5b10506251801320fde44@mail.gmail.com>
Date: Sun, 26 Jun 2005 03:01:35 +0200
From: Paolo Marchetti <natryum@gmail.com>
Reply-To: Paolo Marchetti <natryum@gmail.com>
To: kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpufreq: ondemand+conservative=condemand
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Just change defaults in conservative governor to make it more responsive.
>
Alexey,
I played with conservative governor trying to make it work decently on
my p4 with no results.
As you know it works but it isn't responsive, it takes eons to step up/down.

No matter how I tune sampling_rate & C. conservative governor is useless for me.
Please look at the code, you will see ondemand is better exept for the
"give-me-all-the-power-here-and-now" thing.

ciao,
Paolo
