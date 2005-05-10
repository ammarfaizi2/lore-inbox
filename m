Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbVEJSpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbVEJSpQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 14:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbVEJSpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 14:45:16 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:17058 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261733AbVEJSpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 14:45:11 -0400
Date: Tue, 10 May 2005 11:45:08 -0700
From: Greg KH <gregkh@suse.de>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [RFC/PATCH] unregister_node() for hotplug use
Message-ID: <20050510184508.GA2463@suse.de>
References: <20050420173235.GA17775@kroah.com> <20050422003009.1b96f09c.tokunaga.keiich@jp.fujitsu.com> <20050422003920.GD6829@kroah.com> <20050422113211.509005f1.tokunaga.keiich@jp.fujitsu.com> <20050425230333.6b8dfb33.tokunaga.keiich@jp.fujitsu.com> <20050426065431.GB5889@suse.de> <20050507211141.4829d4c0.tokunaga.keiich@jp.fujitsu.com> <427FE7B3.8080200@us.ibm.com> <20050510202053.3ddd9e7b.tokunaga.keiich@jp.fujitsu.com> <4280FA41.3050403@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4280FA41.3050403@us.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2005 at 11:15:29AM -0700, Matthew Dobson wrote:
> 
> So I think it's probably a good idea to stick the __devinit on
> register_node() and unregister_node(), otherwise we have no marker to know
> which functions to remove for CONFIG_TINY.  Greg?

Like _anyone_ would have CONFIG_NUMA and CONFIG_TINY enabled at the same
time?  I don't think so...

I'll leave it as is for now.

thanks,

greg k-h
