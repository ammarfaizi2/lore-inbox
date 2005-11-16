Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030531AbVKPW1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030531AbVKPW1d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 17:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030530AbVKPW1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 17:27:32 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:7350 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030526AbVKPW1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 17:27:31 -0500
Subject: Re: 2.6.14 X spinning in the kernel
From: Lee Revell <rlrevell@joe-job.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Max Krasnyansky <maxk@qualcomm.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, hugh@veritas.com,
       Dave Airlie <airlied@linux.ie>
In-Reply-To: <1132177953.24066.80.camel@localhost.localdomain>
References: <1132012281.24066.36.camel@localhost.localdomain>
	 <20051114161704.5b918e67.akpm@osdl.org>
	 <1132015952.24066.45.camel@localhost.localdomain>
	 <20051114173037.286db0d4.akpm@osdl.org> <437A6609.4050803@us.ibm.com>
	 <437B9FAC.4090809@qualcomm.com>
	 <1132177953.24066.80.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 17:11:31 -0500
Message-Id: <1132179092.3008.9.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-16 at 13:52 -0800, Badari Pulavarty wrote:
> 	- top loop is for for 10000 times (usec_timeout).

Where does usec_timeout get set anyway?  With a DRM ioctl()?  I looked
at the radeon source and it looks like it defaults to 100000 (not
10000).  And I can't see where it ever gets set to anything but the
default.

Lee

