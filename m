Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbTDEAD1 (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 19:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbTDEAD1 (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 19:03:27 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:3572 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261492AbTDEADX (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 19:03:23 -0500
Date: Fri, 4 Apr 2003 16:14:40 -0800
From: Greg KH <greg@kroah.com>
To: Paul Mackerras <paulus@samba.org>
Cc: petkan@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] small fix to pegasus.c
Message-ID: <20030405001440.GC5230@kroah.com>
References: <16007.34687.590218.260862@nanango.paulus.ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16007.34687.590218.260862@nanango.paulus.ozlabs.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 31, 2003 at 10:10:39AM +1000, Paul Mackerras wrote:
> Using cpu_to_le16p on a __u8 variable is wrong, and gives a compile
> warning on PPC.  It's better to use cpu_to_le16 in this case.  Here is
> a patch to fix it.  Please apply.

Applied, thanks.

greg k-h
