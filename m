Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261713AbULGAU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbULGAU2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 19:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbULGAU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 19:20:28 -0500
Received: from quickstop.soohrt.org ([81.2.155.147]:1480 "EHLO
	quickstop.soohrt.org") by vger.kernel.org with ESMTP
	id S261713AbULGAUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 19:20:17 -0500
Date: Tue, 7 Dec 2004 01:20:12 +0100
From: Karsten Desler <kdesler@soohrt.org>
To: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: _High_ CPU usage while routing (mostly) small UDP packets
Message-ID: <20041207002012.GB30674@quickstop.soohrt.org>
References: <20041206224107.GA8529@soohrt.org> <E1CbSf8-00047p-00@calista.eckenfels.6bone.ka-ip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CbSf8-00047p-00@calista.eckenfels.6bone.ka-ip.net>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Eckenfels <ecki-news2004-05@lina.inka.de> wrote:
> In article <20041206224107.GA8529@soohrt.org> you wrote:
> > Removing the iptables rules helps reducing the load a little, but the
> > majority of time is still spent somewhere else.
> 
> In handling Interrupts. Are those equally sidtributed on eth0 and eth1?

Yes they are.

Thanks,
 Karsten

           CPU0       CPU1       
  0:  117199776  133677244    IO-APIC-edge  timer
  1:          0          9    IO-APIC-edge  i8042
  8:          0          4    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
169:        139  893669684   IO-APIC-level  eth0
177:  919803109      30665   IO-APIC-level  eth1
209:     414257     413316   IO-APIC-level  libata
NMI:          0          0 
LOC:  250918849  250918819 
ERR:          0
MIS:          0
