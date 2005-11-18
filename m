Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030256AbVKRRja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbVKRRja (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 12:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbVKRRja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 12:39:30 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:55777 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030256AbVKRRj3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 12:39:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=HElL5V++mWlpu2fuf/1bqfYv+YvlEP7ZAcb3/8++VOySJtgoGPTl4gxdKfWgmWYHaCdu/QAeJdNeVZSi522ASssCEYaC3IzCAP00k8PDWvC/G/bthSWAt6/mrkw9coV5ppDecldpQeic+tV03pxD62T0zaeIqrUAUlnNk2F3YNw=
Message-ID: <569d37b00511180939t6145a294q1e563c38d9b2f316@mail.gmail.com>
Date: Fri, 18 Nov 2005 12:39:29 -0500
From: Trevor Woerner <twoerner.k@gmail.com>
To: Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: updated latency measurements
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest version of my report which measures the latency of
user-space processes running on Linux via a hardware device is
available. This report measures the latency of the 2.6.14.2 kernel and
compares it to a 2.6.14.2 kernel with Ingo's -rt12 patches.

http://geek.vtnet.ca/embedded.html

You'll probably just want to skip to the results of the high-load scenario here:

http://geek.vtnet.ca/embedded/LatencyTests/html/results-ts3.html

The graphs include: latency measurements, max latency, min latency,
loadavg, and a measure of processor busyness. A separate histogram
indicates measurement distribution.
