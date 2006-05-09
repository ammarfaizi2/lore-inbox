Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbWEIE0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbWEIE0j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 00:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWEIE0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 00:26:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:16837 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751369AbWEIE0j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 00:26:39 -0400
Date: Mon, 8 May 2006 21:25:00 -0700
From: Greg KH <greg@kroah.com>
To: Jan Beulich <jbeulich@novell.com>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org,
       Ram Pai <linuxram@us.ibm.com>
Subject: Re: GPL-only symbols issue
Message-ID: <20060509042500.GA4226@kroah.com>
References: <445F0B6F.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <445F0B6F.76E4.0078.0@novell.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2006 at 09:12:15AM +0200, Jan Beulich wrote:
> Sam,
> 
> would it seem reasonable a request to detect imports of GPL-only
> symbols by non-GPL modules also at build time rather than only at run
> time, and at least warn about such?

Ram has some tools that might catch this kind of thing.  He's posted his
scripts to lkml in the past, try looking in the archives.

thanks,

greg k-h
