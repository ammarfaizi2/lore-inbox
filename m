Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbWDUHlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWDUHlk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 03:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWDUHlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 03:41:40 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:17584 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S1751297AbWDUHlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 03:41:40 -0400
Date: Fri, 21 Apr 2006 09:41:30 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Claudio Scordino <cloud.of.andor@gmail.com>, linux-kernel@vger.kernel.org,
       luto@myrealbox.com, kernel-janitors@lists.osdl.org
Subject: Re: [PATCH] Extending getrusage
Message-ID: <20060421074129.GA31972@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Andrew Morton <akpm@osdl.org>,
	Claudio Scordino <cloud.of.andor@gmail.com>,
	linux-kernel@vger.kernel.org, luto@myrealbox.com,
	kernel-janitors@lists.osdl.org
References: <d0191dad0604200821l3fa0ed70ga2faabe79d7718ec@mail.gmail.com> <20060420162140.0a03e227.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060420162140.0a03e227.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 04:21:40PM -0700, Andrew Morton wrote:
> I'd be reluctant to support this change without a compelling description of
> why we actually want it.

It offers nothing that isn't available elsewhere (I think), except more
cheaply. It also has the potential to be multiplatform one day. Right now to
get the CPU usage of a random pid, one has to implement the equivalent of
/proc/ parsing for each platform.

If at least Linux did 'getrusage for foreign pid', that would clean up
things up somewhat already.

It might even mean a 'portable top', and who knows, more unixes might
follow.

I for one would save work having a getrusage that does this.

	Bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
