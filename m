Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268946AbUHMCOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268946AbUHMCOc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 22:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268947AbUHMCOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 22:14:32 -0400
Received: from main.gmane.org ([80.91.224.249]:64399 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268946AbUHMCOa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 22:14:30 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Date: Fri, 13 Aug 2004 01:29:06 +0200
Message-ID: <yw1xllgkgcl9.fsf@kth.se>
References: <1092099669.5759.283.camel@cube> <cone.1092113232.42936.29067.502@pc.kolivas.org>
 <411BF083.8060406@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 197.80-202-92.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:aDOM/aPDa2m7/nwwkwMuu494IxQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> writes:

> Con Kolivas wrote:
>
>> It was a hard lockup and randomly happened during a cd write,
>> creating my first coaster in a long time... in rt mode ironically
>> which is how it is recommended to be run. So I removed the foolish
>> superuser bit and have had no problem since. Yes it was unaltered
>> cdrecord source and it was the so-called alpha branch and... Not
>> much else I can say about it really?
>
> I said I'd never seen this (true), but it could happen if you were
> burning an audio CD using the ide-scsi or ATA: interface. In 2.6 the
> ATAPI: interface uses DMA. I don't know what the program does if you
> just say dev=/dev/hdx,

Whatever it does, it doesn't load the system noticeably.

-- 
Måns Rullgård
mru@kth.se

