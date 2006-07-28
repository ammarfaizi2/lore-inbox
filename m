Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWG1DWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWG1DWo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 23:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWG1DWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 23:22:44 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:958 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1751399AbWG1DWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 23:22:44 -0400
Date: Thu, 27 Jul 2006 23:22:40 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] #define rwxr_xr_x 0755
Message-ID: <20060728032240.GH24452@filer.fsl.cs.sunysb.edu>
References: <20060727205911.GB5356@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060727205911.GB5356@martell.zuzino.mipt.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 12:59:11AM +0400, Alexey Dobriyan wrote:
> Every time I try to decipher S_I* combos I cry in pain. Often I just
> refer to include/linux/stat.h defines to find out what mode it is
> because numbers are actually quickier to understand.
> 
> Compare and contrast:
> 
> 	0644 vs S_IRUGO|S_IWUSR vs rw_r__r__
> 
> I'd say #2 really sucks.
 
Yep. I like the idea, but I think some kind of prefix is in order.

Josef Sipek.

-- 
"Memory is like gasoline. You use it up when you are running. Of course you
get it all back when you reboot..."; Actual explanation obtained from the
Micro$oft help desk. 
