Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750926AbVKSF1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbVKSF1k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 00:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbVKSF1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 00:27:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38539 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750848AbVKSF1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 00:27:39 -0500
Date: Sat, 19 Nov 2005 00:26:14 -0500
From: Dave Jones <davej@redhat.com>
To: Rob Landley <rob@landley.net>
Cc: Lee Revell <rlrevell@joe-job.com>, Adrian Bunk <bunk@stusta.de>,
       Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051119052613.GC32402@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Rob Landley <rob@landley.net>, Lee Revell <rlrevell@joe-job.com>,
	Adrian Bunk <bunk@stusta.de>,
	Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>,
	linux-kernel@vger.kernel.org
References: <1132020468.27215.25.camel@mindpipe> <200511182043.34655.rob@landley.net> <1132370572.6874.56.camel@mindpipe> <200511182138.30017.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511182138.30017.rob@landley.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 09:38:29PM -0600, Rob Landley wrote:

 > that entire menu doesn't show up unless you've selected ISA under the bus menu 
 > (which I thought means we probe for ISA slots, not that we don't support ISA 
 > devices built onto the motherboard).

Common misconception.  CONFIG_ISA means "Show me drivers that need
an ISA bus". Nothing more, nothing less.

You can't actually probe for the existance of an ISA slot, only
(unsafely) probe for a specific ISA device by poking ports.

		Dave

