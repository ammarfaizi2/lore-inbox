Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbVBHRIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVBHRIS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 12:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVBHRGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 12:06:23 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:1516 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261582AbVBHRGO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 12:06:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=hF4bnrxMTQpCE4uXx2nIkwv0lDnMEMb8idsUeD/hkHoCOHLBYU1QH43s12jxYSX3ijjOjfRr9IOf3EMMfehcMi+MDdXv7MaCXALLeTukiaOVbeVNCtouLyErCiiUfXcODViQarPjtYsja6CBS9NkW4FiZxKb/y2ZfxZ2ST1NOo4=
Message-ID: <e130a7170502080906596561d7@mail.gmail.com>
Date: Tue, 8 Feb 2005 12:06:14 -0500
From: jon ross <jonross@gmail.com>
Reply-To: jon ross <jonross@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: VM disk cache behavior.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an app with a small fixed memory footprint that does a lot of
random reads from a large file. I thought if I added more memory to
the machine the VM would do more caching of the disk, but added memory
does not seem to make any difference. I played with some of the params
in /proc/sys/vm and none of them seem to have any effect.

I tired both a 2.4.20 & 2.6.10 kernels with no difference.

The machine is a Dell 2560. I tired memory configs of 512M, 1G, 4G and
the average read-times do not change.

Do I need to set/compile anything to allow the VM to use the memory?
If is was a way to tell how much memory the VM is using for a drive
cache I could at least tell if my kernel is miss-configured or my app
sucks.

Thanks,

-Jon
