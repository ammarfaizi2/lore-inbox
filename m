Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbUCIXb1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 18:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbUCIXb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 18:31:27 -0500
Received: from mail.kroah.org ([65.200.24.183]:64424 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262448AbUCIX1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 18:27:54 -0500
Date: Tue, 9 Mar 2004 15:04:27 -0800
From: Greg KH <greg@kroah.com>
To: "Kevin O'Connor" <kevin@koconnor.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: i2c_use_client broken
Message-ID: <20040309230427.GA14038@kroah.com>
References: <20040304063446.GA19655@arizona.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040304063446.GA19655@arizona.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2004 at 01:34:46AM -0500, Kevin O'Connor wrote:
> The i2c_inc_use_client test looks backward - the code should look like:
> 
>         if (i2c_inc_use_client(client))
>                 return -ENODEV;

Russell King just sent me a patch to fix this.

thanks,

greg k-h
