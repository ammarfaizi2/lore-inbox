Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266571AbUBESJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 13:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266572AbUBESJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 13:09:58 -0500
Received: from mail.kroah.org ([65.200.24.183]:15066 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266571AbUBESJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 13:09:56 -0500
Date: Thu, 5 Feb 2004 10:09:32 -0800
From: Greg KH <greg@kroah.com>
To: "Hefty, Sean" <sean.hefty@intel.com>, linux-kernel@vger.kernel.org
Cc: Troy Benjegerdes <hozer@hozed.org>,
       "Woodruff, Robert J" <woody@co.intel.com>,
       "Magro, Bill" <bill.magro@intel.com>,
       "Woodruff, Robert J" <woody@jf.intel.com>,
       infiniband-general@lists.sourceforge.net
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in the linux kernel
Message-ID: <20040205180932.GE13075@kroah.com>
References: <C1B7430B33A4B14F80D29B5126C5E94703262582@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C1B7430B33A4B14F80D29B5126C5E94703262582@orsmsx401.jf.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05, 2004 at 10:01:13AM -0800, Hefty, Sean wrote:
> As an FYI, the code is available for download on bitkeeper at
> http://infiniband.bkbits.net/iba.  We're still working on providing a
> tarball and patch for 2.6, but if you would like to see the code now, it
> is available.

Oh, I've seen that code, and still feel ill after looking at some of
it...

Come on, implementing your own spinlocks (and getting it wrong) and
atomit_t?  Why in the world would you _ever_ want to do that.

That code needs a _lot_ of cleanup to make it into the kernel tree.

Good luck,

greg k-h
