Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbWEIWrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWEIWrs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 18:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbWEIWrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 18:47:47 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:54146 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751343AbWEIWrr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 18:47:47 -0400
Date: Tue, 9 May 2006 15:50:50 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Greg KH <greg@kroah.com>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 33/35] Add the Xenbus sysfs and virtual device hotplug driver.
Message-ID: <20060509225050.GA24291@moss.sous-sol.org>
References: <20060509084945.373541000@sous-sol.org> <20060509085200.826853000@sous-sol.org> <20060509194044.GA374@kroah.com> <20060509215314.GU24291@moss.sous-sol.org> <20060509220158.GA20564@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509220158.GA20564@kroah.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH (greg@kroah.com) wrote:
> Either.  You seem to mention a lot of nested depths in sysfs or "files",
> yet your above tree doesn't show that.  And I don't understand what you
> mean by frontend/backend here either?  Is it a sysfs thing?  Or a Xen
> thing?

The files are xenstore, it's part of the communication between frontend
and backend.  The frontend is the device driver in the guest domain
which is just an I/O channel to the backend driver.  The backend is in
the driver domain where the physical hardware can be driven.

thanks,
-chris
