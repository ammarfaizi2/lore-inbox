Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265309AbUATAd2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 19:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265167AbUATA1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:27:10 -0500
Received: from mail.kroah.org ([65.200.24.183]:56237 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264537AbUATAEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 19:04:08 -0500
Date: Mon, 19 Jan 2004 16:04:05 -0800
From: Greg KH <greg@kroah.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kobj_to_dev ?
Message-ID: <20040120000405.GA5656@kroah.com>
References: <3FC7B008-487C-11D8-AED9-000A95A0560C@us.ibm.com> <20040117001739.GB3840@kroah.com> <400C3D87.3010502@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400C3D87.3010502@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19, 2004 at 02:26:47PM -0600, Hollis Blanchard wrote:
> Greg KH wrote:
> >
> >How about just adding a find_device() function to the driver core, where
> >you pass in a name and a type, so that others can use it?
> 
> Something like this?

Very nice, yes.  But I'll rename it to device_find() to keep the
namespace sane.  Sound ok?

thanks,

greg k-h
