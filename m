Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270969AbTHOVIX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 17:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270982AbTHOVIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 17:08:23 -0400
Received: from mail.kroah.org ([65.200.24.183]:41641 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270969AbTHOVIX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 17:08:23 -0400
Date: Fri, 15 Aug 2003 13:51:58 -0700
From: Greg KH <greg@kroah.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 - sysfs sensor nameing inconsistency
Message-ID: <20030815205158.GB4760@kroah.com>
References: <200307152214.38825.arvidjaar@mail.ru> <20030715201822.GA5040@kroah.com> <200307262200.51781.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307262200.51781.arvidjaar@mail.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 26, 2003 at 10:00:51PM +0400, Andrey Borzenkov wrote:
> 
> Attached is patch against 2.6.0-test1 that adds type_name to all in-tree 
> sensors; it sets it to the same values as corr. 2.4 senors and (in one case) 
> changes client name to match that of 2.4.
> 
> Assuming this patch (or variant thereof) is accepted I can then produce 
> libsensors patch that will easily reuse current sensors.conf. I have already 
> done it for gkrellm and as Mandrake is going to include 2.6 in next release 
> sensors support becomes more of an issue.

I like this idea, but now that the name logic has changed in the i2c
code, care to re-do this patch?  Just set the name field instead of
creating a new file in sysfs.

Sound ok?

thanks,

greg k-h
