Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWH2Fnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWH2Fnp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 01:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWH2Fnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 01:43:45 -0400
Received: from liaag1ae.mx.compuserve.com ([149.174.40.31]:28872 "EHLO
	liaag1ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751165AbWH2Fno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 01:43:44 -0400
Date: Tue, 29 Aug 2006 01:36:25 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Linux v2.6.18-rc5
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Message-ID: <200608290140_MC3-1-C9AC-F35@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060829020107.GA31565@kroah.com>

On Mon, 28 Aug 2006 19:01:07 -0700, Greg KH wrote:

> > From: Chuck Ebbert <76306.1226@compuserve.com>
> > Subject: PCI: Cannot allocate resource region 7 of bridge 0000:00:04.0
>
> I thought this was resolved.
>
> Chuck, do you still have issues with this with the -rc5 release?

Yes.  I think this is a separate problem from the one that was fixed in -rc5.

Digging deeper shows there are no devices behind the bridges anyway, so
maybe this message should be expected?  (Resource start is zero for all
resources, that's what causes the message.)

-- 
Chuck

