Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262928AbUKXXtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262928AbUKXXtV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 18:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262989AbUKXXqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 18:46:44 -0500
Received: from over.ny.us.ibm.com ([32.97.182.111]:49284 "EHLO
	over.ny.us.ibm.com") by vger.kernel.org with ESMTP id S262944AbUKXXpN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 18:45:13 -0500
Date: Wed, 24 Nov 2004 14:35:00 -0800
From: Greg KH <greg@kroah.com>
To: Justin Thiessen <jthiessen@penguincomputing.com>
Cc: phil@netroedge.com, khali@linux-fr.org, sensors@Stimpy.netroedge.com,
       linux-kernel@vger.kernel.org
Subject: Re: adm1026 driver port for kernel 2.6.10-rc2 (patch includes driver, patch to Kconfig, and patch to Makefile) [fixed]
Message-ID: <20041124223500.GA3787@kroah.com>
References: <20041102221745.GB18020@penguincomputing.com> <NN38qQl1.1099468908.1237810.khali@gcu.info> <20041103164354.GB20465@penguincomputing.com> <20041118185612.GA20728@penguincomputing.com> <20041123165236.GA4936@penguincomputing.com> <20041124213600.GA3165@kroah.com> <20041124231017.GA10171@penguincomputing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041124231017.GA10171@penguincomputing.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2004 at 03:10:17PM -0800, Justin Thiessen wrote:
> On Wed, Nov 24, 2004 at 01:36:00PM -0800, Greg KH wrote:
> > Hm, this looks like a bug:
> 
> <snip egregious stupidity>
> 
> > Care to fix this up and resend the whole patch?
> 
> Affirmative.
> 
> > Oh, and it should be "Signed-off-by:" not "Signed off by:" like you had
> > used :)
> 
> See below:

Applied, thanks.

Oh, I did make one change:

> +/* Adjust fan_min to account for new fan divisor */
> +void fixup_fan_min(struct device *dev, int fan, int old_div)

This should be static.

thanks,

greg k-h
