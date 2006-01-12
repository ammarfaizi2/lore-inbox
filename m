Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030355AbWALKca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030355AbWALKca (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 05:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030353AbWALKca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 05:32:30 -0500
Received: from omx3-ext.sgi.com ([192.48.171.26]:22416 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1030350AbWALKc3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 05:32:29 -0500
Date: Thu, 12 Jan 2006 02:31:59 -0800
From: Paul Jackson <pj@sgi.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org, greg@kroah.com,
       linux-ia64@vger.kernel.org
Subject: Re: [CFT 9/29] Add tiocx bus_type probe/remove methods
Message-Id: <20060112023159.d76f5867.pj@sgi.com>
In-Reply-To: <20060112014551.8e7888c3.pj@sgi.com>
References: <20060105142951.13.01@flint.arm.linux.org.uk>
	<20060105142951.13.09@flint.arm.linux.org.uk>
	<20060112014551.8e7888c3.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pj wrote:
> This patch looks broken.  I see the lines:
> 
> +	.remove = cx_device_remove,
> -	cx_driver->driver.remove = cx_driver_remove;

It looks like Adrian already posted a patch for this - thanks.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
