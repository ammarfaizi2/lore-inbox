Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbVLEP7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbVLEP7F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 10:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbVLEP7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 10:59:05 -0500
Received: from rtr.ca ([64.26.128.89]:20454 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932448AbVLEP7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 10:59:03 -0500
Message-ID: <439463C4.7040905@rtr.ca>
Date: Mon, 05 Dec 2005 10:59:00 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Andi Kleen <ak@suse.de>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Andrew Morton <akpm@osdl.org>, cpufreq <cpufreq@www.linux.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CPU frequency display in /proc/cpuinfo
References: <20051202181927.GD9766@wotan.suse.de> <20051202104320.A5234@unix-os.sc.intel.com> <20051204164335.GB32492@isilmar.linta.de> <20051204183239.GE14247@wotan.suse.de> <1133725767.19768.12.camel@mindpipe> <20051205011611.GA12664@redhat.com>
In-Reply-To: <20051205011611.GA12664@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >I can't think of a single valid reason why a program would want
 >to know the MHz rating of a CPU.

Humans like to know what their machines are doing.

Simple as that:  it's for the end-users, and the place they look
for it is always /proc/cpuinfo (since that works on every platform
and on kernels prior to the 2.[56].* series.

Not useful as an accurate number for any programming algorithms,
but it is used to satisfy human curiosity.  A lot.

--ml
