Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263783AbTDXRN6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 13:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263785AbTDXRN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 13:13:58 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:7586 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263783AbTDXRN5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 13:13:57 -0400
Date: Thu, 24 Apr 2003 10:27:58 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, chrisg@0-in.com,
       sensors@stimpy.netroedge.com
Subject: Re: it87 driver converted to sysfs
Message-ID: <20030424172758.GA27365@kroah.com>
References: <20030424150113.GJ1069@iucha.net> <20030424160431.GC18690@kroah.com> <20030424165132.GK1069@iucha.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030424165132.GK1069@iucha.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 11:51:32AM -0500, Florin Iucha wrote:
> On Thu, Apr 24, 2003 at 09:04:31AM -0700, Greg KH wrote:
> > A few comments:
> [snip]
> > Other than those very minor things the patch looks good.  Mind fixing
> > them and sending it to me again?
> 
> Thank you, fixed patch inlined.

Thanks, I've applied this and will send it on in a bit.

Oops, I've fixed the call to check_region, which should not have been
made.  Sorry I missed that last time.

greg k-h
