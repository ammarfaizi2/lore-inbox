Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262469AbUBYEWe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 23:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262475AbUBYEWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 23:22:34 -0500
Received: from mail.kroah.org ([65.200.24.183]:4321 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262469AbUBYEWd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 23:22:33 -0500
Date: Tue, 24 Feb 2004 20:22:24 -0800
From: Greg KH <greg@kroah.com>
To: Dave Boutcher <sleddog@us.ibm.com>
Cc: Ryan Arnold <rsa@us.ibm.com>, linux-kernel@vger.kernel.org,
       boutcher@us.ibm.com, Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: new driver (hvcs) review request and sysfs questions
Message-ID: <20040225042224.GA5135@kroah.com>
References: <1077667227.21201.73.camel@SigurRos.rchland.ibm.com> <20040225012845.GA3909@kroah.com> <opr3woijnwl6e53g@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <opr3woijnwl6e53g@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 09:12:09PM -0600, Dave Boutcher wrote:
> 
> It is also true that it is unlike the representation of most other things 
> in sysfs, so perhaps this is the time to change before it gets too baked 
> into things.

I agree.  Is there any reason we _have_ to stick with the OF names?  It
seems to me to make more sense here not to, to make it more like the
rest of the kernel.

That is, if the address after the @ is unique.  Is that always the case?

thanks,

greg k-h
