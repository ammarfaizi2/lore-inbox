Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263070AbVAFXeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263070AbVAFXeu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 18:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263209AbVAFXeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 18:34:05 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:51093 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263070AbVAFXco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 18:32:44 -0500
Date: Thu, 6 Jan 2005 15:12:44 -0800
From: Greg KH <greg@kroah.com>
To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] I2C: Remove the i2c_client id field
Message-ID: <20050106231244.GA22174@kroah.com>
References: <20041227230402.272fafd0.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041227230402.272fafd0.khali@linux-fr.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2004 at 11:04:02PM +0100, Jean Delvare wrote:
> Hi Greg, hi all,
> 
> While porting various hardware monitoring drivers to Linux 2.6 and
> otherwise working on i2c drivers in 2.6, I found that the i2c_client
> structure has an "id" field (of type int) which is mostly unused. I am
> not exactly sure why it was introduced in the first place, and since the
> i2c subsystem code was significantly reworked since, it might not
> actually matter.

It's fine with me if it's dropped.

thanks,

greg k-h
