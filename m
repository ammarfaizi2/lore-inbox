Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265173AbUBDBFv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 20:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265902AbUBDBFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 20:05:51 -0500
Received: from mail.kroah.org ([65.200.24.183]:51937 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265173AbUBDBFs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 20:05:48 -0500
Date: Tue, 3 Feb 2004 17:03:25 -0800
From: Greg KH <greg@kroah.com>
To: "Woodruff, Robert J" <woody@co.intel.com>
Cc: Troy Benjegerdes <hozer@hozed.org>,
       "Woodruff, Robert J" <woody@jf.intel.com>,
       infiniband-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in the linux kernel
Message-ID: <20040204010325.GB23386@kroah.com>
References: <F595A0622682C44DBBE0BBA91E56A5ED1C3671@orsmsx410.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F595A0622682C44DBBE0BBA91E56A5ED1C3671@orsmsx410.jf.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 03, 2004 at 04:17:36PM -0800, Woodruff, Robert J wrote:
> 
> I heard from a friend of mine that 2.6 was closed to new features. 
> What sayith the community on allowing additional experimental drivers
> (like the infiniband access layer) into 2.6 ? Can we still submit
> something or do we have to wait till 2.7 ?

If it's a subsystem that does not touch any of the existing kernel (with
the exception of adding it to the build and Kconfig), then it probably
will not be a problem to add.

But then again, that all depends on what the code looks like, and none
of us have seen that yet :)

thanks,

greg k-h
