Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262113AbVANT1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbVANT1U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 14:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbVANTNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 14:13:46 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:58868 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261999AbVANTLc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 14:11:32 -0500
Date: Fri, 14 Jan 2005 11:07:25 -0800
From: Greg KH <greg@kroah.com>
To: Karim Yaghmour <karim@opersys.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [PATCH 4/4] relayfs for 2.6.10: headers
Message-ID: <20050114190725.GA15337@kroah.com>
References: <41E736C4.3080806@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E736C4.3080806@opersys.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 10:04:36PM -0500, Karim Yaghmour wrote:
> --- linux-2.6.10/include/linux/klog.h	1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.6.10-relayfs/include/linux/klog.h	2005-01-13 10:40:25.000000000 -0800
> @@ -0,0 +1,24 @@
> +/*
> + * KLOG		Generic Logging facility built upon the relayfs infrastructure

Why is this header in the relayfs code?  Shouldn't it be a separate
patch?

thanks,

greg k-h
