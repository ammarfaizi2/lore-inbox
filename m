Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbVBAIvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbVBAIvD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 03:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbVBAIvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 03:51:02 -0500
Received: from mail.kroah.org ([69.55.234.183]:7609 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261867AbVBAIu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 03:50:56 -0500
Date: Tue, 1 Feb 2005 00:28:53 -0800
From: Greg KH <greg@kroah.com>
To: Kylene Hall <kjhall@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, emilyr@us.ibm.com, toml@us.ibm.com,
       tpmdd-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/1] tpm: fix cause of SMP stack traces -- updated version
Message-ID: <20050201082853.GC22068@kroah.com>
References: <Pine.LNX.4.58.0412081546470.24510@jo.austin.ibm.com> <Pine.LNX.4.58.0412161632200.4219@jo.austin.ibm.com> <Pine.LNX.4.58.0412171642570.9229@jo.austin.ibm.com> <Pine.LNX.4.58.0412201146060.10943@jo.austin.ibm.com> <29495f1d041221085144b08901@mail.gmail.com> <Pine.LNX.4.58.0412211209410.14092@jo.austin.ibm.com> <Pine.LNX.4.58.0501121236180.2453@jo.austin.ibm.com> <Pine.LNX.4.58.0501181621200.2473@jo.austin.ibm.com> <Pine.LNX.4.58.0501181735110.13908@jo.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501181735110.13908@jo.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 05:39:53PM -0600, Kylene Hall wrote:
> There were misplaced spinlock acquires and releases in the probe, close and release 
> paths which were causing might_sleep and schedule while atomic error messages accompanied 
> by stack traces when the kernel was compiled with SMP support. Bug reported by Reben Jenster 
> <ruben@hotheads.de>
> 
> Thanks,
> Kylie
>  
> Signed-off-by: Kylene Hall <kjhall@us.ibm.com>

Applied, thanks.

greg k-h

