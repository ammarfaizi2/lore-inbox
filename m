Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbTDKXLc (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 19:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbTDKXLb (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 19:11:31 -0400
Received: from inet-mail2.oracle.com ([148.87.2.202]:35051 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id S261839AbTDKXL3 (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 19:11:29 -0400
Date: Fri, 11 Apr 2003 16:21:09 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Andries.Brouwer@cwi.nl, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>, pbadari@us.ibm.com
Subject: Re: [patch for playing] Patch to support 4000 disks and maintain backward compatibility
Message-ID: <20030411232109.GB4917@ca-server1.us.oracle.com>
References: <UTC200304111945.h3BJjU409008.aeb@smtp.cwi.nl> <1050092073.2078.219.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1050092073.2078.219.camel@mulgrave>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 03:14:32PM -0500, James Bottomley wrote:
> > Linux does not arbitrarily break old systems. The aim must be
> > to have all combinations of (old/new) kernel with (old/new) glibc
> > to work well in all situations where old kernel + old glibc worked.

	100%

> Well, if you're going to do this, at least make it possible to tie all
> the sd devices to a single major (i.e. the numeric compatibility layer
> simply maps to the new single major scheme internally).  It would also
> be nice for numeric compatibility to be a compile time option too...

	The real issue is that almost all consumers of the new kernel
will have a /dev populated with old numbers.  Only new installs
(completely fresh) won't be burdened.  And new installs won't be the
majority of 2.6 users for quite some time after 2.6.0.

Joel

-- 

"Copy from one, it's plagiarism; copy from two, it's research."
        - Wilson Mizner

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
