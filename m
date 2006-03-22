Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWCVV7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWCVV7i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 16:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWCVV7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 16:59:38 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:28480 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S932070AbWCVV7h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 16:59:37 -0500
Message-ID: <4421C8C9.10007@cfl.rr.com>
Date: Wed, 22 Mar 2006 16:59:37 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
CC: "H. Peter Anvin" <hpa@zytor.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-kernel@vger.kernel.org
Subject: Re: VFAT: Can't create file named 'aux.h'?
References: <1142890822.5007.18.camel@localhost.localdomain> <20060320134533.febb0155.rdunlap@xenotime.net> <dvn835$lvo$1@terminus.zytor.com> <Pine.LNX.4.61.0603211840020.21376@yvahk01.tjqt.qr> <44203B86.5000003@zytor.com> <Pine.LNX.4.61.0603211854150.21376@yvahk01. <87y7z2l159.fsf@duaron.myhome.or.jp>
In-Reply-To: <87y7z2l159.fsf@duaron.myhome.or.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Mar 2006 21:59:48.0600 (UTC) FILETIME=[F00AAF80:01C64DFB]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14340.000
X-TM-AS-Result: No--3.700000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears to simply be stored as "aux" under windows.  The filesystem 
itself has no reserved names.  The handling of AUX and CON and friends 
is just special case handling done at the win32 api level.

OGAWA Hirofumi wrote:
> Could you/anyone check what shortname is used for "AUX" if it is created
> in cmd.exe?
> 
> Windows may be storing it as shortname, because it seems to be using
> completely separated namespace for devices (I guessed from result of
> google).
> 
> Thanks.

