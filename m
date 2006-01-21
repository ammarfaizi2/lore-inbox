Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWAUAJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWAUAJG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 19:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbWAUAJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 19:09:05 -0500
Received: from mail.host.bg ([85.196.174.5]:31918 "EHLO mail.host.bg")
	by vger.kernel.org with ESMTP id S932189AbWAUAJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 19:09:04 -0500
From: Anton Titov <a.titov@host.bg>
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060120145006.0a773262.akpm@osdl.org>
References: <1137337516.11767.50.camel@localhost>
	 <20060120041114.7f06ecd8.akpm@osdl.org>
	 <Pine.LNX.4.64.0601201401500.14198@turbotaz.ourhouse>
	 <1137793685.11771.58.camel@localhost>
	 <20060120145006.0a773262.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-GetXRQbaCwNJtZDWARVY"
Message-Id: <1137801984.11771.62.camel@localhost>
Mime-Version: 1.0
Subject: Re: OOM Killer killing whole system
Organization: Host.bg
Date: Sat, 21 Jan 2006 02:09:00 +0200
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GetXRQbaCwNJtZDWARVY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2006-01-20 at 14:50 -0800, Andrew Morton wrote:
> That's great, thanks.
> 
> This is 2.6.15 and we have a deadly bug in scsi.
> 
> Next time you reboot 2.6.15 on that machine can you please send the output
> of `dmesg -s 1000000'?  You might have to set CONFIG_LOG_BUF_SHIFT=17 to
> prevent it from being truncated.

Sure, here is it, just rebooted, seems complete to me.

15mins after rebooting I have:

vip ~ # cat /proc/slabinfo | grep scsi
scsi_cmd_cache      6160   6160    384   10    1 : tunables   54   27
8 : slabdata    616    616      0
vip ~ # uptime
 02:04:49 up 15 min,  1 user,  load average: 0.16, 0.21, 0.19

--=-GetXRQbaCwNJtZDWARVY
Content-Disposition: attachment; filename=dmesg.gz
Content-Type: application/x-gzip; name=dmesg.gz
Content-Transfer-Encoding: base64

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



--=-GetXRQbaCwNJtZDWARVY--

