Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262445AbTEVBvC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 21:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbTEVBvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 21:51:02 -0400
Received: from holomorphy.com ([66.224.33.161]:32137 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262445AbTEVBvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 21:51:01 -0400
Date: Wed, 21 May 2003 19:03:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, jamesclv@us.ibm.com,
       haveblue@us.ibm.com, pbadari@us.ibm.com, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com, mannthey@us.ibm.com
Subject: Re: userspace irq balancer
Message-ID: <20030522020354.GO8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Gerrit Huizenga <gh@us.ibm.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>, jamesclv@us.ibm.com,
	haveblue@us.ibm.com, pbadari@us.ibm.com,
	linux-kernel@vger.kernel.org, johnstul@us.ibm.com,
	mannthey@us.ibm.com
References: <58830000.1053566935@[10.10.2.4]> <E19If8R-0000YU-00@w-gerrit2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E19If8R-0000YU-00@w-gerrit2>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 May 2003 18:28:56 PDT, "Martin J. Bligh" wrote:
>> I think the word you're groping for here is "microkernel".

On Wed, May 21, 2003 at 06:44:46PM -0700, Gerrit Huizenga wrote:
> Oh, yeah.  Page replacement policy in user level.  That one was
> a real winner.

That's incorrect. Page replacement policy at the user-level was
proposed but AIUI not included in Mach. You're thinking of external
pagers, which are grossly inefficient but have only to do with the
I/O to fetch and store pages belonging to a memory object, not with
page replacement. Mach's page replacement policy was global SEGQ.

This is specifically discussed by Vahalia.


-- wli
