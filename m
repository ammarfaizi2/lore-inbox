Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbUDHVvM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 17:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbUDHVvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 17:51:12 -0400
Received: from mail.kroah.org ([65.200.24.183]:38613 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261928AbUDHVvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 17:51:11 -0400
Date: Thu, 8 Apr 2004 14:50:55 -0700
From: Greg KH <greg@kroah.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, braam@cs.cmu.edu, coda@cs.cmu.edu
Subject: Re: [PATCH 2.6.5] Add sysfs class support to fs/coda/psdev.c
Message-ID: <20040408215055.GB14183@kroah.com>
References: <7290000.1081457670@dyn318071bld.beaverton.ibm.com> <7970000.1081458781@dyn318071bld.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7970000.1081458781@dyn318071bld.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2004 at 02:13:01PM -0700, Hanna Linder wrote:
> 
> Greg reminded me you can't put a / in a file name (duh).
> 
> > +		class_simple_device_add(coda_psdev_class, MKDEV(CODA_PSDEV_MAJOR,i), 
> > +				NULL, "coda/%d", i);
> 
> Here is the fixed patch:

Applied, thanks.

greg k-h
