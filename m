Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVFCM0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVFCM0q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 08:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVFCM0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 08:26:46 -0400
Received: from 1-1-1-9a.ghn.gbg.bostream.se ([82.182.69.4]:30403 "EHLO
	scream.fjortis.info") by vger.kernel.org with ESMTP id S261237AbVFCM0o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 08:26:44 -0400
Date: Fri, 3 Jun 2005 14:32:10 +0200
From: Andreas Henriksson <andreas@fjortis.info>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       matt_domsch@dell.com, Greg KH <greg@kroah.com>
Subject: Re: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new Dell BIOS update driver
Message-ID: <20050603123210.GA21913@scream.fjortis.info>
References: <20050602232634.GA32462@littleblue.us.dell.com> <1117756728.3656.45.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117756728.3656.45.camel@pegasus>
User-Agent: mutt-ng devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2005 at 01:58:48AM +0200, Marcel Holtmann wrote:

> 
> > +	if ((rc = fill_last_packet(data, length)) != 0)
> 
> Use "if (!(rc = fill_last_packet(data, length)))".
> 

Even better like this?

	rc = fill_last_packet(data, length);
	if (!rc)


> 
> > +		if ( rc == 0 )
> 
> Spaces.
> 

Plus use: if (!rc)


Regards,
Andreas Henriksson
