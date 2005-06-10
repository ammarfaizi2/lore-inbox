Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262608AbVFJRVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbVFJRVv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 13:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbVFJRVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 13:21:51 -0400
Received: from colin.muc.de ([193.149.48.1]:11535 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S262608AbVFJRVu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 13:21:50 -0400
Date: 10 Jun 2005 19:21:49 +0200
Date: Fri, 10 Jun 2005 19:21:49 +0200
From: Andi Kleen <ak@muc.de>
To: Shaohua Li <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       Ashok Raj <ashok.raj@intel.com>, Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [PATCH]x86-x86_64 flush cache for CPU hotplug
Message-ID: <20050610172149.GP1683@muc.de>
References: <1118374208.7510.6.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118374208.7510.6.camel@linux-hp.sh.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2005 at 11:30:08AM +0800, Shaohua Li wrote:
> Hi,
> We should flush cache at CPU hotplug. An error has been observed data is
> corrupted after CPU hotplug in CPUs with bigger cache.

Did you see that with actual hardware CPU hotplug? With software
for testing only hotplug it should not make any difference.

/Andi
