Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030346AbVI3Pys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346AbVI3Pys (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 11:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030347AbVI3Pys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 11:54:48 -0400
Received: from xproxy.gmail.com ([66.249.82.202]:59797 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030346AbVI3Pys convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 11:54:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=K4a5x5/oOOGuMOto3heg55Gj4Pej3Tl9oriX2thE3T3TE18DUjWxLuAHYO5hNluV0yxdPdoKPaSOOO/jAHChGtZb8oirQF9nw28rmUXk+OO3RhcW+BA57HCI1osRXqgQygw0C7uMKWyiJ409oy0gLWNfB+T7VcDUAHFr76wnQTI=
Message-ID: <5bdc1c8b0509300854o2f8ad7e9oa7736da916479458@mail.gmail.com>
Date: Fri, 30 Sep 2005 08:54:47 -0700
From: Mark Knecht <markknecht@gmail.com>
Reply-To: Mark Knecht <markknecht@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.14-rc2-rt7 - AMD64 runs GREAT! (threaded/non-threaded interrupts?)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   I finally managed to find an acceptable set of config options last
even that build correctly. The kernel came right up and is working
wonderfully on my Gentoo system. I've been up for a few hours this
morning with Jack going at 128/2. (<6mS latency) Music is streaming
with no xruns, even while doing emerge sync/emerge world operations.


   One question. In earlier rt kernels there was a way to set specific
ISR routinges as threaded or non-threaded through
/proc/irq/ISR#/DEVICE/threaded. Does anything like this exist anymore?
This feature provided (on earlier rt kernels) an extra degree of
safety that I appreciated. Granted it wasn't for everybody, but I fell
it helped my systems when used.

   Thanks to Ingo & Daniel Walker & Lee Revell for helping me get this
kernel working, and thanks to all who make this possible. We audio
guys really appreciate it.

With best regards,
Mark
