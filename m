Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272320AbTHNMTW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 08:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272321AbTHNMTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 08:19:22 -0400
Received: from mail.zmailer.org ([62.240.94.4]:62674 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S272320AbTHNMTV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 08:19:21 -0400
Date: Thu, 14 Aug 2003 15:19:17 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Simon Haynes <simon@baydel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: File access
Message-ID: <20030814121917.GX6898@mea-ext.zmailer.org>
References: <67597854DA5@baydel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67597854DA5@baydel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 12:32:18PM +0100, Simon Haynes wrote:
> I am currently developing a module which I would like to configure
> via a simple text file. 
> 
> I cannot seem to find any information on accessing files via a kernel 
> module.
> 
> Is this possible and if so how is it done ?

  Yes, but it is rather complicated business, and really should not
  be done in kernel.   It can be done, but like Richard said, defining
  your own set of IOCTLs for the device is better.  The complicated
  configuration file parsing can then reside in the user-space utility
  program.

> Many Thanks
> Simon.

/Matti Aarnio
