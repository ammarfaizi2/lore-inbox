Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbTEKVYq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 17:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbTEKVYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 17:24:46 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:17024 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S261241AbTEKVYq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 17:24:46 -0400
From: Con Kolivas <kernel@kolivas.org>
To: DevilKin-LKML <devilkin-lkml@blindguardian.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.420] Unexplained repeatable Oops
Date: Mon, 12 May 2003 07:39:29 +1000
User-Agent: KMail/1.5.1
References: <200305112052.51938.devilkin-lkml@blindguardian.org>
In-Reply-To: <200305112052.51938.devilkin-lkml@blindguardian.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305120739.30154.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 May 2003 04:52, DevilKin-LKML wrote:
> On my main machine at home I have encountered since this morning an Oops
> that never happened before. It happened when I was playing a game of Diablo
> II through Winex (yes, with the Nvidia modules loaded and stuff loaded from
> VMWare). This oops I didn't bother to capture, since I know that oops'es
> from a tainted kernel are not accepted.
> 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
> (rev 40) Subsystem: ABIT Computer Corp.: Unknown device a702
>         Flags: bus master, stepping, medium devsel, latency 0
>         Capabilities: [c0] Power Management version 2


Good old VIA chipset. I solved a similar problem by underclocking a cpu on a 
similar chipset :-(

Try the mprime client stress test to ensure your hardware is ok.
www.mersenne.org

Con
