Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVFMVRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVFMVRb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 17:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbVFMVPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 17:15:40 -0400
Received: from mail.kroah.org ([69.55.234.183]:38877 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261400AbVFMVLD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 17:11:03 -0400
Date: Mon, 13 Jun 2005 13:54:38 -0700
From: Greg KH <greg@kroah.com>
To: Mark Bidewell <mark.bidewell@alumni.clemson.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.11.12 I2C error
Message-ID: <20050613205437.GA14455@kroah.com>
References: <42ADD458.3090906@alumni.clemson.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42ADD458.3090906@alumni.clemson.edu>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 02:45:44PM -0400, Mark Bidewell wrote:
> When I attempt to compile 2.6.11.12 from a full download. I get the 
> following messages:
> 
> include/linux/i2c.h:58: error: array type has incomplete element type
> include/linux/i2c.h:197: error: array type has incomplete element type
> 
> I think the problem has to do with the forward declartion used in those 
> lines. 
> 
> I am using gcc 4.0 on FC4 final

gcc 4.0 does not built the 2.6.11.whatever kernel properly.  You need to
use the 2.6.12-rc kernel go fix these issues.

thanks,

greg k-h
