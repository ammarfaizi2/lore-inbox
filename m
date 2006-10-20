Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992558AbWJTHcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992558AbWJTHcq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 03:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992560AbWJTHcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 03:32:46 -0400
Received: from poczta.o2.pl ([193.17.41.142]:56240 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S2992558AbWJTHcp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 03:32:45 -0400
Date: Fri, 20 Oct 2006 09:37:52 +0200
From: Jarek Poplawski <jarkao2@o2.pl>
To: Krzysztof Oledzki <olel@ans.pl>
Cc: linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
Subject: Re: 3.2GHz cpus with cpufreq become 2.8GHz
Message-ID: <20061020073752.GC1898@ff.dom.local>
Mail-Followup-To: Jarek Poplawski <jarkao2@o2.pl>,
	Krzysztof Oledzki <olel@ans.pl>, linux-kernel@vger.kernel.org,
	cpufreq@lists.linux.org.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610200022320.30089@bizon.gios.gov.pl>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-10-2006 00:25, Krzysztof Oledzki wrote:
...
> I will check this, thank you. BTW: what wrong is with p4-clockmod? I was 
> not able to find any information that it is broken and should not be used?

At least it is very suspected:

"Subject: Hardware bug or kernel bug?
On Mon, Oct 16, 2006 at 03:32:38PM +0100, David Johnson wrote:
..
> I've found the culprit - CPU Frequency Scaling.
> With it enabled I get the reboots, with it disabled I don't. That's the same
> with every kernel version I've tried (2.6.19-rc1+rc2, 2.6.17.13 & Centos'
> 2.6.9) The system was using the p4-clockmod driver and the ondemand governor.

> I'm still not sure exactly what the problem is - the reboots only happen in
> the circumstances I've mentioned and are not triggered by changes in clock
> speed alone - but disabling cpufreq seems to make it go away... "

Cheers,

Jarek P.
