Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268343AbUHFVV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268343AbUHFVV3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 17:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268339AbUHFVUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 17:20:22 -0400
Received: from mail.kroah.org ([69.55.234.183]:24207 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268342AbUHFVQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 17:16:41 -0400
Date: Fri, 6 Aug 2004 14:16:19 -0700
From: Greg KH <greg@kroah.com>
To: Robert Love <rml@ximian.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] add kobject_get_path
Message-ID: <20040806211618.GA26492@kroah.com>
References: <1091824013.7939.66.camel@betsy> <1091824903.7939.80.camel@betsy> <20040806205022.GA26135@kroah.com> <1091825763.7939.84.camel@betsy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091825763.7939.84.camel@betsy>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 04:56:03PM -0400, Robert Love wrote:
> On Fri, 2004-08-06 at 13:50 -0700, Greg KH wrote:
> 
> > I do too.  One problem though, get_kobj_path_length and fill_kobj_path
> > are only built if CONFIG_HOTPLUG is enabled.  Care to respin this patch
> > by moving the functions outside of that #define?
> 
> Hrm, did not notice that.  kobject_get_path() was inside there, too.
> 
> I presume these functions are still meaningful if !CONFIG_HOTPLUG?

Well, they weren't until your function needed them :)

> Here we go.  Thanks,

Applied, thanks.

greg k-h
