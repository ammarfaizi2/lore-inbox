Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965147AbWFIUip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965147AbWFIUip (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 16:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965146AbWFIUin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 16:38:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5293 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965147AbWFIUil (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 16:38:41 -0400
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mingming Cao <cmm@us.ibm.com>, linux-fsdevel@vger.kernel.org,
       Andreas Dilger <adilger@clusterfs.com>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <448997FA.50109@garzik.org>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	 <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int>
	 <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>
	 <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>  <448997FA.50109@garzik.org>
Content-Type: text/plain
Date: Fri, 09 Jun 2006 21:38:25 +0100
Message-Id: <1149885505.5776.103.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2006-06-09 at 11:47 -0400, Jeff Garzik wrote:

> think about The Experience:  Suddenly users that could use 2.4.x and 
> 2.6.x are locked into 2.6.18+, by the simple and common act of writing 
> to a file.

No.

The default is --- user writes to file on 2.6.18+, goes back to 2.4, and
everything still keeps on working just fine.  

Or, user says "I *specifically* request this feature that I *know* is
not compatible with older kernels", and then they get just that.
Extents are not going to be on by default.  Please, we've got more sense
than that!

Just like the developer who says "I *specifically* code for this fancy
new vmsplice syscall" gets exactly the same.

--Stephen


