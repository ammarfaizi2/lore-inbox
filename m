Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbVIRNuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbVIRNuy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 09:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932067AbVIRNuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 09:50:54 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:16655 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932065AbVIRNuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 09:50:54 -0400
Date: Sun, 18 Sep 2005 14:50:51 +0100
From: R Kimber <rkimber@ntlworld.com>
To: linux-kernel@vger.kernel.org
Subject: kswapd0 uses 98% of cpu with 2.6.11
Message-Id: <20050918145051.4b244894.rkimber@ntlworld.com>
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.6.4; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a 2GB dual opteron workstation running Ubuntu 5.04 with
2.6.11-1-amd64-k8-smp on MSI K8T Master2-FAR

I am experiencing kswapd using 98% of cpu.  My Googling implied that
this had been fixed in 2.6.11 - is there still a known problem?  I
wasn't very clear about this after searching the archives, and I'd be
grateful for information - I'm not an expert I'm afraid, and I'd like
to be sure it isn't a hardware problem. If there is a problem, is there
a workaround (e.g. a boot parameter that I might supply?) or is it OK
simply to allow the cpu usage to continue (temperatures are only a
couple of degrees higher).

I don't know if it's relevent but I notice that dmesg reports:-

Restarting tasks...<6> Strange, khubd not stopped
 Strange, kswapd0 not stopped
 Strange, kseriod not stopped
 done

Swap is not actually used:-

             total       used     free     shared    buffers
cached Mem:   2055816   438068    1617748   0
49528  164808
 -/+ buffers/cache:     223732    1832084
Swap:      2104464          0    2104464

I'd appreciate a Cc, as I'm not subscribed.
Thanks,
- Richard.
-- 
Richard Kimber
http://www.psr.keele.ac.uk/
rkimber@ntlworld.com
