Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030528AbVKPWhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030528AbVKPWhl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 17:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030530AbVKPWhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 17:37:41 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:39627 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030528AbVKPWhk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 17:37:40 -0500
Subject: Re: 2.6.14 X spinning in the kernel
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Max Krasnyansky <maxk@qualcomm.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, hugh@veritas.com,
       Dave Airlie <airlied@linux.ie>
In-Reply-To: <1132179092.3008.9.camel@mindpipe>
References: <1132012281.24066.36.camel@localhost.localdomain>
	 <20051114161704.5b918e67.akpm@osdl.org>
	 <1132015952.24066.45.camel@localhost.localdomain>
	 <20051114173037.286db0d4.akpm@osdl.org> <437A6609.4050803@us.ibm.com>
	 <437B9FAC.4090809@qualcomm.com>
	 <1132177953.24066.80.camel@localhost.localdomain>
	 <1132179092.3008.9.camel@mindpipe>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 14:37:32 -0800
Message-Id: <1132180652.24066.87.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-16 at 17:11 -0500, Lee Revell wrote:
> On Wed, 2005-11-16 at 13:52 -0800, Badari Pulavarty wrote:
> > 	- top loop is for for 10000 times (usec_timeout).
> 
> Where does usec_timeout get set anyway?  With a DRM ioctl()?  I looked
> at the radeon source and it looks like it defaults to 100000 (not
> 10000).  And I can't see where it ever gets set to anything but the
> default.
> 
> Lee

Don't know. I added a printk() and it shows

Nov 16 11:43:51 elm3b23 kernel: usec timeout 10000

Thanks,
Badari

