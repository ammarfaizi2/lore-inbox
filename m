Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbVAGTey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbVAGTey (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 14:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVAGTa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 14:30:29 -0500
Received: from colin2.muc.de ([193.149.48.15]:61444 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261545AbVAGT3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 14:29:04 -0500
Date: 7 Jan 2005 20:29:02 +0100
Date: Fri, 7 Jan 2005 20:29:02 +0100
From: Andi Kleen <ak@muc.de>
To: YhLu <YhLu@tyan.com>
Cc: Matt Domsch <Matt_Domsch@dell.com>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, jamesclv@us.ibm.com, suresh.b.siddha@intel.com
Subject: Re: 256 apic id for amd64
Message-ID: <20050107192902.GA6518@muc.de>
References: <3174569B9743D511922F00A0C94314230729130F@TYANWEB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174569B9743D511922F00A0C94314230729130F@TYANWEB>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Without subtract boot_cpu_id, phys_pkg_id will return 8.
> With that, It will return 0.

Normally this is set up that the CPUs come first and then the IO-APICs.
Why is this not possible with 8111 and 8131?

-Andi
