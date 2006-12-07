Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032400AbWLGQuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032400AbWLGQuM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 11:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032401AbWLGQuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 11:50:12 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:39422 "EHLO iradimed.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1032400AbWLGQuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 11:50:08 -0500
Message-ID: <4578465D.7030104@cfl.rr.com>
Date: Thu, 07 Dec 2006 11:50:37 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Marc Haber <mh+linux-kernel@zugschlus.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 file content corruption on ext3
References: <20061207155740.GC1434@torres.l21.ma.zugschlus.de>
In-Reply-To: <20061207155740.GC1434@torres.l21.ma.zugschlus.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Dec 2006 16:50:17.0772 (UTC) FILETIME=[C65E36C0:01C71A1F]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14858.003
X-TM-AS-Result: No--12.728100-5.000000-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Haber wrote:
> I went back to 2.6.18.3 to debug this, and the system ran for three
> days without problems and without corrupting
> /var/cache/apt/pkgcache.bin. After booting 2.6.19 again, it took three
> hours for the file corruption to show again.
> 
> I do not have an idea what could cause this other than the 2.6.19
> kernel.
<snip>
> I'll happily deliver information that might be needed to nail down
> this issue. Can anybody give advice about how to solve this?

I'd say start git bisecting to track down which commit the problem 
starts at.

