Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbWBJR1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWBJR1w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 12:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWBJR1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 12:27:52 -0500
Received: from animx.eu.org ([216.98.75.249]:3487 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S1751340AbWBJR1v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 12:27:51 -0500
Date: Fri, 10 Feb 2006 12:31:10 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Greg KH <greg@kroah.com>
Cc: Alex Davis <alex14641@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Let's get rid of  ide-scsi
Message-ID: <20060210173110.GA29028@animx.eu.org>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Alex Davis <alex14641@yahoo.com>, linux-kernel@vger.kernel.org
References: <20060210002148.37683.qmail@web50201.mail.yahoo.com> <20060210003614.GA26114@animx.eu.org> <20060210052404.GB29421@kroah.com> <20060210121107.GC27814@animx.eu.org> <20060210163114.GA26203@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060210163114.GA26203@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Feb 10, 2006 at 07:11:07AM -0500, Wakko Warner wrote:
> > Greg KH wrote:
> > > What "seperate USB block layer"?
> > 
> > Maybe not a "block layer", but there was this Under drivers/block devices in
> > the config:
> > Low Performance USB Block driver
> 
> What is your objection to this driver?  It fills a real need for people
> who do not want the whole scsi stack in their kernels (embedded, memory
> constraints, closed systems, etc.), and probably is not even considered
> "Low Performance" anymore.

Ok, now this I did not know which is why I personally objected to it.  I saw
no reason to have it with usb-storage since both did something similar.  Now
that I know what it's purpose is, I don't see a problem with it as far as
availability to the ones who are low memory, embedded, etc, but I won't need
it myself.  I normally use systtems with scsi controllers and need the full
scsi layer.

If/When libata takes over ide in general, how many of these machine will
then require the scsi layer?  I would think all systems would except ones
without internal disks (non-usb/firewire).

I do appreciate the info, thanks.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
 Got Gas???
