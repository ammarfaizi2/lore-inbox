Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbTH1Cip (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 22:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263679AbTH1Cip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 22:38:45 -0400
Received: from janus.zeusinc.com ([205.242.242.161]:9526 "EHLO
	zso-proxy.zeusinc.com") by vger.kernel.org with ESMTP
	id S263620AbTH1Cio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 22:38:44 -0400
Subject: Poor IPSec performance with 2.6 kernels
From: Tom Sightler <ttsig@tuxyturvy.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1062038303.2947.11.camel@iso-8590-lx.zeusinc.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 27 Aug 2003 22:38:24 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I'm looking for suggestions as to why my IPSec performance is so bad
when using the built in 2.6 IPSec implementation.

My setup is pretty simple, a tunnel with a Watchguard Firebox on one end
and an AMD K6/333 on the other end running Redhat 9.  I've used two
different IPsec implementations on the Linux system, one is
SuperFreeS/WAN with a patched Redhat kernel using the available SRPMS
and the other is the built-in 2.6 IPSec code with racoon.

My Internet connection is a DSL circuit that typically delivers about
150KB/s.  When I connect with SuperFreeS/WAN my VPN throughput is quite
good, averaging about 125KB/s (this seems about reasonable with
overhead) but when making the identical connection with racoon and the
2.6 kernel I can only achieve 50KB/s.  I've been unable to come up with
any reason why this would be the case.

Any hints would be appreciated.

Later,
Tom




