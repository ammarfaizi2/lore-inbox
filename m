Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVAIL7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVAIL7N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 06:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVAIL7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 06:59:13 -0500
Received: from [212.20.225.142] ([212.20.225.142]:3348 "EHLO
	orlando.wolfsonmicro.main") by vger.kernel.org with ESMTP
	id S261207AbVAIL7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 06:59:10 -0500
Subject: Re: [PATCH 1/5] WM97xx touch driver AC97 plugin
From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Zabolotny <zap@homelink.ru>,
       Vincent Sanders <vince@simtec.co.uk>, Ian Molton <spyro@f2s.com>
In-Reply-To: <41E0640C.1030500@f2s.com>
References: <1105106557.9143.1001.camel@cearnarfon>
	 <1105223060.24592.133.camel@krustophenia.net>  <41E0640C.1030500@f2s.com>
Content-Type: text/plain
Message-Id: <1105271630.3204.7.camel@odin.exize.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 09 Jan 2005 11:59:07 +0000
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Jan 2005 11:59:08.0632 (UTC) FILETIME=[A0073D80:01C4F642]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-01-08 at 22:51, Ian Molton wrote:
> Lee Revell wrote:
> 
> > Why an OSS driver and not ALSA?  OSS is deprecated.
> 
>  From my POV, because I havent got time to port it to ALSA yet ;-)
> 
> from another POV, because ALSA is broken on ARM (or was), and other 
> platforms, wrt the mmap() operation mode. this makes it a bit pointless 
> to port a driver to thats mainly used for arm based PDAs...

It's now also used on MIPS and x86 platforms, in PDA, Cell phone and POS
applications. 

I will be speaking to the ALSA list when I return from vacation about
the possibility of a similar plugin architecture for AC97 codecs.

Liam

