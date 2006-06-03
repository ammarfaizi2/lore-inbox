Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751826AbWFCXVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbWFCXVh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 19:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbWFCXVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 19:21:37 -0400
Received: from colo.lackof.org ([198.49.126.79]:46737 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1751826AbWFCXVg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 19:21:36 -0400
Date: Sat, 3 Jun 2006 17:21:33 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [BUG](-mm)pci_disable_device function clear bars_enabled element
Message-ID: <20060603232133.GA7109@colo.lackof.org>
References: <447E91CE.7010705@intel.com> <20060601024611.A32490@unix-os.sc.intel.com> <20060601171559.GA16288@colo.lackof.org> <20060601113625.A4043@unix-os.sc.intel.com> <447FA920.9060509@jp.fujitsu.com> <20060602055642.GC1501@colo.lackof.org> <447FE943.3010702@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447FE943.3010702@jp.fujitsu.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2006 at 04:31:15PM +0900, Kenji Kaneshige wrote:
> I think that list would be very useful. But as you said, there are
> other steps remaining than ones I came up with at once. I can't
> deal with the steps of all of them...

Ok. I'm motivated to clean up/rewrite that file...
Greg, you want that peice meal or all in one patch?

> BTW, Section 3 says "Before you do anything with the device you've
> found, you need to enable it by calling pci_enable_device()...". I
> think it would be one of the causes of misunderstanding the order
> between pci_request_regions() and pci_enable_device().

I agree. I'll fix that.

thanks,
grant

