Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVBGRrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVBGRrT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 12:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbVBGRrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 12:47:19 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:58050 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261239AbVBGRrL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 12:47:11 -0500
Subject: Re: [PATCH] PCI Hotplug: remove incorrect rpaphp firmware
	dependency
From: John Rose <johnrose@austin.ibm.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       greg@kroah.com.torvalds, akpm@osdl.org
In-Reply-To: <1107798068.31219.6.camel@sinatra.austin.ibm.com>
References: <200502031908.j13J8ggb031915@hera.kernel.org>
	 <1107795637.19262.426.camel@hades.cambridge.redhat.com>
	 <1107798068.31219.6.camel@sinatra.austin.ibm.com>
Content-Type: text/plain
Message-Id: <1107798322.31219.8.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 07 Feb 2005 11:45:22 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could we please get David's fix in for 2.6.11, since it's apparently
affecting boot in some situations?

Thanks-
John

On Mon, 2005-02-07 at 11:41, John Rose wrote:
> > Er, use the result of the get_children_props() call only if it _failed_?
> > I suspect that wasn't your intention. This makes my G5 boot again:
> 
> Doh, good catch!  This was an oversight while patching multiple trees
> for this bug.  Previous versions of that function use 1 for success. 
> Sigh.  BTW, you're running an RPA module on your G5?
> 
> Thanks-
> John

