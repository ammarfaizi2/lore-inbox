Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbVCJEdC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbVCJEdC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 23:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbVCJEaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 23:30:15 -0500
Received: from avexch02.qlogic.com ([198.70.193.200]:43482 "EHLO
	avexch01.qlogic.com") by vger.kernel.org with ESMTP id S261379AbVCJE1b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 23:27:31 -0500
Date: Wed, 9 Mar 2005 20:28:01 -0800
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       axboe@suse.de
Subject: Re: Direct io on block device has performance regression on 2.6.x kernel
Message-ID: <20050310042801.GR11328@plap.qlogic.org>
Mail-Followup-To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	'Andrew Morton' <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	axboe@suse.de
References: <20050309182550.0291c6fd.akpm@osdl.org> <200503100347.j2A3lRg28975@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503100347.j2A3lRg28975@unix-os.sc.intel.com>
Organization: QLogic Corporation
X-Operating-System: Linux 2.6.8-24.11-default
User-Agent: Mutt/1.5.6i
X-OriginalArrivalTime: 10 Mar 2005 04:27:26.0047 (UTC) FILETIME=[7669F6F0:01C52529]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Mar 2005, Chen, Kenneth W wrote:

> Andrew Morton wrote Wednesday, March 09, 2005 6:26 PM
> > What does "1/3 of the total benchmark performance regression" mean?  One
> > third of 0.1% isn't very impressive.  You haven't told us anything at all
> > about the magnitude of this regression.
> 
> 2.6.9 kernel is 6% slower compare to distributor's 2.4 kernel (RHEL3).  Roughly
> 2% came from storage driver (I'm not allowed to say anything beyond that, there
> is a fix though).
> 

Ok now, that statement piqued my interest -- since looking through a
previous email it seems you are using the qla2xxx driver.  Care to
elaborate?

Regards,
Andrew Vasquez
