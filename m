Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWBJQbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWBJQbr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 11:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbWBJQbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 11:31:47 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:4525 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S932162AbWBJQbT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 11:31:19 -0500
Date: Fri, 10 Feb 2006 08:31:14 -0800
From: Greg KH <greg@kroah.com>
To: Alex Davis <alex14641@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Let's get rid of  ide-scsi
Message-ID: <20060210163114.GA26203@kroah.com>
References: <20060210002148.37683.qmail@web50201.mail.yahoo.com> <20060210003614.GA26114@animx.eu.org> <20060210052404.GB29421@kroah.com> <20060210121107.GC27814@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060210121107.GC27814@animx.eu.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2006 at 07:11:07AM -0500, Wakko Warner wrote:
> Greg KH wrote:
> > On Thu, Feb 09, 2006 at 07:36:14PM -0500, Wakko Warner wrote:
> > > 
> > > I am also against the seperate USB block layer, I personally saw no use in
> > > it.
> > 
> > What "seperate USB block layer"?
> 
> Maybe not a "block layer", but there was this Under drivers/block devices in
> the config:
> Low Performance USB Block driver

What is your objection to this driver?  It fills a real need for people
who do not want the whole scsi stack in their kernels (embedded, memory
constraints, closed systems, etc.), and probably is not even considered
"Low Performance" anymore.

thanks,

greg k-h
