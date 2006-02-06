Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWBFVjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWBFVjD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 16:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWBFVjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 16:39:03 -0500
Received: from atpro.com ([12.161.0.3]:20243 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S932267AbWBFVjC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 16:39:02 -0500
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Mon, 6 Feb 2006 16:38:44 -0500
To: David Chow <davidchow@shaolinmicro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux drivers management
Message-ID: <20060206213844.GC12270@voodoo>
Mail-Followup-To: David Chow <davidchow@shaolinmicro.com>,
	linux-kernel@vger.kernel.org
References: <43E71AD7.5070600@shaolinmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E71AD7.5070600@shaolinmicro.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/06 05:45:59PM +0800, David Chow wrote:
> Dear maintainers,
> 
> Is there any work in Linux undergoing to separate Linux drivers and the 
> the main kernel, and manage drivers using a package management system 
> that only manages kernel drivers and modules? If this can be done, the 
> kernel maintenance can be simple, and will end-up with a more stable 
> (less frequent changed) kernel API for drivers, also make every 
> developers of drivers happy.
> 
> Would like to see that happens .
> 


> regards,
> David Chow

Debian includes a tool call module-assistant that allows one to download,
compile and install the 3rd party modules that they package pretty
painlessly. But it obviously doesn't include the drivers already in the
kernel since they're included in the kernel packages.

Jim.
