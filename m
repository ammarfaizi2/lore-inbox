Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263398AbTJBQ6g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 12:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263400AbTJBQ6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 12:58:36 -0400
Received: from dsl-hkigw4g29.dial.inet.fi ([80.222.54.41]:23168 "EHLO
	dsl-hkigw4g29.dial.inet.fi") by vger.kernel.org with ESMTP
	id S263398AbTJBQ6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 12:58:35 -0400
Date: Thu, 2 Oct 2003 19:59:20 +0300 (EEST)
From: Petri Koistinen <petri.koistinen@iki.fi>
X-X-Sender: petri@dsl-hkigw4g29.dial.inet.fi
To: linux-kernel@vger.kernel.org
Subject: ksoftirqd & kswapd returning nothing while non-void
Message-ID: <Pine.LNX.4.58.0310021953260.5991@dsl-hkigw4g29.dial.inet.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I just compiled latest 2.6.0-test kernel and noticed these two warnings:

kernel/softirq.c: In function `ksoftirqd':
kernel/softirq.c:352: warning: no return statement in function returning non-void

mm/vmscan.c: In function `kswapd':
mm/vmscan.c:1045: warning: no return statement in function returning non-void

Is here something that should be worried about?

Best regards,
Petri Koistinen
