Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbULNScI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbULNScI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 13:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbULNScI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 13:32:08 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:52637 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261591AbULNSby (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 13:31:54 -0500
Date: Tue, 14 Dec 2004 10:31:22 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Can't build current -bk tree or 2.6.10-rc3-bk8
Message-ID: <20041214183122.GA15897@kroah.com>
References: <20041214173659.GA9525@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041214173659.GA9525@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2004 at 09:36:59AM -0800, Greg KH wrote:
> Both 2.6.10-rc3-bk8 and the latest (as of 9:00 am PST) copy of Linus's
> BitKeeper tree give me the following build error:
> 
>   CC      init/main.o
> init/main.c: In function `unknown_bootoption':
> init/main.c:299: warning: asm operand 1 probably doesn't match constraints
> init/main.c:299: error: impossible constraint in `asm'
> 
> That means the BUG(); statement is unbuildable.
> 
> This is with gcc 3.4.3.   .config is attached below.
> 
> Anyone else seeing this?

Hm, this looks like a distcc bug, not a kernel issue.  Sorry for the
noise.

greg k-h
