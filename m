Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWHJTp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWHJTp0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWHJTpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:45:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:16060 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751484AbWHJToo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:44:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=KOtz1uXU65wdJV+UE9uw8TRxLkk5kB0fx3J50mHEw6WX6Qd3luK5PDYIfOv4MueGBBrT6J3Z2853JXdMJ82P5DOwPq4LPDYQSaQ7l0G51nLsRAtcmZkgdd1jooUsEZgc758t8MCnuFSjkEq5n+tefyVkUEv7s9xVa05kTGpGDlw=
Date: Thu, 10 Aug 2006 23:44:40 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/9] sector_t format string
Message-ID: <20060810194440.GA6845@martell.zuzino.mipt.ru>
References: <1155172843.3161.81.camel@localhost.localdomain> <20060809234019.c8a730e3.akpm@osdl.org> <20060810191747.GL20581@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060810191747.GL20581@ca-server1.us.oracle.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 12:17:47PM -0700, Joel Becker wrote:
> On Wed, Aug 09, 2006 at 11:40:19PM -0700, Andrew Morton wrote:
> > On Wed, 09 Aug 2006 18:20:43 -0700
> > Mingming Cao <cmm@us.ibm.com> wrote:
> > 
> > > Define SECTOR_FMT to print sector_t in proper format
> > 
> > We've thus-far avoided doing this.  In fact a similar construct in
> > device-mapper was recently removed.
> 
> 	Yeah, OCFS2 had similar formats, and we were asked to change
> them to naked casts before inclusion.  Seems quite consistent with the
> rest of the kernel.

Will

	printk("%S", sector_t);

kill at least one kitten?

