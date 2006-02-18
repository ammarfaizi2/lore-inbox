Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWBRCmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWBRCmq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 21:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWBRCmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 21:42:46 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:48559 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750727AbWBRCmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 21:42:45 -0500
Subject: Re: Re[2]: 2.6.16 serious consequences / GPL_EXPORT_SYMBOL / USB
	drivers of major vendor excluded
From: Lee Revell <rlrevell@joe-job.com>
To: s.schmidt@avm.de
Cc: Greg KH <greg@kroah.com>, torvalds@osdl.org, kkeil@suse.de,
       linux-kernel@vger.kernel.org, opensuse-factory@opensuse.org,
       libusb-devel@lists.sourceforge.net
In-Reply-To: <OFED05BE20.31E2BACE-ONC1257115.005DE6CA-C1257117.004F2C48@avm.de>
References: <OFED05BE20.31E2BACE-ONC1257115.005DE6CA-C1257117.004F2C48@avm.de>
Content-Type: text/plain
Date: Fri, 17 Feb 2006 21:42:43 -0500
Message-Id: <1140230563.2733.171.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-16 at 15:24 +0100, s.schmidt@avm.de wrote:
> Only the kernel offers low latency and timeline processing
> which is required for soft DSP alike processing. 

Sorry, but this set off my hyperbole detector.  Ever hear of a VST
plugin?  On Linux, people do realtime DSP stuff with JACK in user space
all the time that (no offense) makes a soft modem look like a toy in
comparison, like process 32 channels of 24 bit audio at 96KHz through a
reverb, amp modelers, equalizers, pitch correction, etc.

http://jackit.sourceforge.net/apps/
http://www.ardour.org/

On a recent kernel you don't even need to be root to get reliable RT
scheduling ;-)

Lee

