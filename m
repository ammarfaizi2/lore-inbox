Return-Path: <linux-kernel-owner+w=401wt.eu-S1754113AbWLXGLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754113AbWLXGLP (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 01:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754133AbWLXGLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 01:11:15 -0500
Received: from colo.lackof.org ([198.49.126.79]:40901 "EHLO colo.lackof.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754113AbWLXGLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 01:11:15 -0500
Date: Sat, 23 Dec 2006 23:11:13 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Greg KH <greg@kroah.com>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 1/5] Update Documentation/pci.txt
Message-ID: <20061224061113.GD24131@colo.lackof.org>
References: <456404E2.1060102@jp.fujitsu.com> <20061122182804.GE378@colo.lackof.org> <45663EE8.1080708@jp.fujitsu.com> <20061124051217.GB8202@colo.lackof.org> <20061206072651.GG17199@kroah.com> <20061210072508.GA12272@colo.lackof.org> <20061215170207.GB15058@kroah.com> <20061218071133.GA1738@colo.lackof.org> <20061222114658.01da661b.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061222114658.01da661b.randy.dunlap@oracle.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2006 at 11:46:58AM -0800, Randy Dunlap wrote:
...
> > +pci_register_driver() call requires passing in a table of function
> > +calls and thus dictates the high level structure of a driver.
> 
> s/calls/pointers/ ?

Yes. I was thinking "call table" or "jump table".
But you are correct that the struct contains "function pointers".

I've adopted all the other changes as well and just reposted a v7 of pci.txt.

thanks!
grant
