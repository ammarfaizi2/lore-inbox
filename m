Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWHJTUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWHJTUQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWHJTUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:20:15 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:23765 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1750799AbWHJTUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:20:13 -0400
Date: Thu, 10 Aug 2006 12:17:47 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/9] sector_t format string
Message-ID: <20060810191747.GL20581@ca-server1.us.oracle.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, cmm@us.ibm.com,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
References: <1155172843.3161.81.camel@localhost.localdomain> <20060809234019.c8a730e3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060809234019.c8a730e3.akpm@osdl.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 11:40:19PM -0700, Andrew Morton wrote:
> On Wed, 09 Aug 2006 18:20:43 -0700
> Mingming Cao <cmm@us.ibm.com> wrote:
> 
> > Define SECTOR_FMT to print sector_t in proper format
> 
> We've thus-far avoided doing this.  In fact a similar construct in
> device-mapper was recently removed.

	Yeah, OCFS2 had similar formats, and we were asked to change
them to naked casts before inclusion.  Seems quite consistent with the
rest of the kernel.

Joel

-- 

"Can any of you seriously say the Bill of Rights could get through
 Congress today?  It wouldn't even get out of committee."
	- F. Lee Bailey

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
