Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262515AbVCBWXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbVCBWXz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 17:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbVCBWS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 17:18:57 -0500
Received: from fep31-0.kolumbus.fi ([193.229.0.35]:44243 "EHLO
	fep31-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S262499AbVCBWOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 17:14:50 -0500
Date: Thu, 3 Mar 2005 00:15:56 +0200 (EET)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Mark Yeatman <myeatman@vale-housing.co.uk>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Problems with SCSI tape rewind / verify on 2.4.29
In-Reply-To: <20050302165917.GA3235@logos.cnet>
Message-ID: <Pine.LNX.4.61.0503030001510.9132@kai.makisara.local>
References: <E7F85A1B5FF8D44C8A1AF6885BC9A0E472B886@ratbert.vale-housing.co.uk>
 <20050302120332.GA27882@logos.cnet> <Pine.LNX.4.61.0503022253360.9132@kai.makisara.local>
 <20050302165917.GA3235@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2005, Marcelo Tosatti wrote:

> On Wed, Mar 02, 2005 at 11:17:19PM +0200, Kai Makisara wrote:
...
> > BTW, this "fix" by Solar Designer introduces a bug to 2.4.29: a tape 
> > driver is supposed to return ENOMEM in the case that was changed to return 
> > EIO ;-(
> 
> Reverted.
> 
Thanks.

...
> Thanks for the cluebat Kai, is this problem fixed in newer versions of tar? 
> 
The current CVS version seems to have the same code I quoted.

> I suspect v2.4 should work with older versions of tar, so we should keep 
> "lseek" working to make it happy. What is your opinion?
> 
I commented this in the other reply I just sent and I don't have a clear 
preference. I just hope that 2.4 and 2.6 are fixed in a compatible way.

-- 
Kai
