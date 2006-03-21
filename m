Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030424AbWCUPGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030424AbWCUPGX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 10:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030427AbWCUPGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 10:06:22 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:50143 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1030424AbWCUPGW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 10:06:22 -0500
Message-ID: <44201672.8000501@cfl.rr.com>
Date: Tue, 21 Mar 2006 10:06:26 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Yaroslav Rastrigin <yarick@it-territory.ru>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: VFAT: Can't create file named 'aux.h'?
References: <1142890822.5007.18.camel@localhost.localdomain> <Pine.LNX.4.61.0603202244370.11933@yvahk01.tjqt.qr> <200603210849.20224.yarick@it-territory.ru> <Pine.LNX.4.61.0603210644530.1898@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0603210644530.1898@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Mar 2006 15:06:29.0447 (UTC) FILETIME=[082E7D70:01C64CF9]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14337.000
X-TM-AS-Result: No--2.500000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> 
> Also, CON is a sensitive name on WIN/2000. This can hang the
> browser. The "@#+^%!@#" devices still exist:
> 
> C:\> copy con xxx.xxx
> 
> .... from the shell will wait forever.
> 

Not quite.  This is the same as doing a cp /dev/stdin xxx.xxx on linux. 
  It will read from stdin until it sees an EOF.  On windows, eof is 
ctrl-z instead of ctrl-d; hit that and the copy command will finish.



