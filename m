Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161097AbWJKQRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161097AbWJKQRh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 12:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030671AbWJKQRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 12:17:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:49607 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030670AbWJKQRg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 12:17:36 -0400
Subject: Re: [PATCH] ext3: fsid for statvfs
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Pekka J Enberg <penberg@cs.helsinki.fi>,
       Bryan Henderson <hbryan@us.ibm.com>, Andries Brouwer <aebr@win.tue.nl>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Andreas Dilger <adilger@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20061010133636.6217a11b.akpm@osdl.org>
References: <Pine.LNX.4.64.0610101131001.10574@sbz-30.cs.Helsinki.FI>
	 <20061010133636.6217a11b.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 11 Oct 2006 17:11:50 +0100
Message-Id: <1160583110.11329.15.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27.rhel4.6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2006-10-10 at 13:36 -0700, Andrew Morton wrote:

> > Update ext3_statfs to return an FSID that is a 64 bit XOR of the 128 bit
> > filesystem UUID as suggested by Andreas Dilger. See the following Bugzilla
> > entry for details:
> > 
> >   http://bugzilla.kernel.org/show_bug.cgi?id=136
> > 
> > Cc: Andreas Dilger <adilger@clusterfs.com>
> > Cc: Stephen Tweedie <sct@redhat.com>
> > Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
> 
> Deja vu.  Gosh, has it really been four years?
> 
> Combatants cc'ed ;)

Looks entirely reasonable to me.

--Stephen


