Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965185AbWEYPAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965185AbWEYPAm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 11:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965186AbWEYPAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 11:00:42 -0400
Received: from fmr20.intel.com ([134.134.136.19]:61595 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S965185AbWEYPAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 11:00:42 -0400
Date: Mon, 22 May 2006 14:35:01 -0700
From: mark gross <mgross@linux.intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Doug Thompson <norsk5@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6]  EDAC Patch Set
Message-ID: <20060522213501.GB9881@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20060524174303.2323.qmail@web50102.mail.yahoo.com> <20060524214203.44cc1adb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060524214203.44cc1adb.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2006 at 09:42:03PM -0700, Andrew Morton wrote:
> drivers/edac/e752x_edac.c: In function `e752x_probe1':
> drivers/edac/e752x_edac.c:932: warning: `mci' might be used uninitialized in this function
> drivers/edac/e752x_edac.c:933: warning: `pvt' might be used uninitialized in this function
> 
> And these are indeed both box-killing bugs.  I'm sure you were seeing this
> warning as well.
> 
> There's this, plus the compile error, plus the ifdef proliferation.  I'll
> wait for version 2, thanks.

Doug, can you take these?  

--mgross

