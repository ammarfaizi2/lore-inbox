Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbTENOZR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 10:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbTENOZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 10:25:17 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:44706 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262288AbTENOZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 10:25:15 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16066.21702.890215.630000@gargle.gargle.HOWL>
Date: Wed, 14 May 2003 16:37:58 +0200
From: mikpe@csd.uu.se
To: alexander.riesen@synopsys.COM
Cc: linux-laptop@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69+bk: oops in apmd after waking up from suspend mode
In-Reply-To: <20030514141121.GA17036@Synopsys.COM>
References: <20030514094813.GA14904@Synopsys.COM>
	<16066.16102.618836.204556@gargle.gargle.HOWL>
	<20030514134600.GA16533@Synopsys.COM>
	<16066.19659.609760.316141@gargle.gargle.HOWL>
	<20030514141121.GA17036@Synopsys.COM>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Riesen writes:
 > I'm not sure if my glibc uses sysenter. But I'd like to have the system
 > prepared if I eventually get one which does.

RH9 on a P6/K7 or higher will use sysenter. Old P5s don't have it.

 > not really. Somewhere fix_processor_context+0x5f/0x100, that's where EIP
 > points.

I need to know your .config and gcc version if I'm to investigate this.
Otherwise I can't build a kernel similar to yours, and without that,
the EIP address you quoted is meaningless to me.

/Mikael
