Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262606AbUFQTuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbUFQTuy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 15:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbUFQTuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 15:50:54 -0400
Received: from mail.kroah.org ([65.200.24.183]:41126 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262453AbUFQTs5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 15:48:57 -0400
Date: Thu, 17 Jun 2004 12:47:39 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Zabolotny <zap@homelink.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Backlight and LCD module patches [1]
Message-ID: <20040617194739.GA15983@kroah.com>
References: <20040617223514.2e129ce9.zap@homelink.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040617223514.2e129ce9.zap@homelink.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 10:35:14PM +0400, Andrew Zabolotny wrote:
> Hello!
> 
> I've tried to fulfill all the requirements that various people presented to
> the previous version of this patch; this and the following letter contains
> the fixed version of the patch that is proposed to be included into the
> mainstream kernel.

You didn't fulfill my requirement that this patch is not needed at all :)

So no, I'm not going to accept this, you need to change your lcd code to
pass around pointers to the proper structures, instead of trying to rely
on the name of a device.  Because of this, I'm not going to apply your
second patch.

thanks,

greg k-h
