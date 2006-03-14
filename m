Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751876AbWCNPgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876AbWCNPgY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 10:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751836AbWCNPgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 10:36:23 -0500
Received: from mail.kroah.org ([69.55.234.183]:47547 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750726AbWCNPgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 10:36:21 -0500
Date: Tue, 14 Mar 2006 07:34:55 -0800
From: Greg KH <gregkh@suse.de>
To: "Moore, Eric" <Eric.Moore@lsil.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       James.Bottomley@SteelEye.com, hch@lst.de
Subject: Re: [PATCH ] drivers/base/bus.c - export reprobe
Message-ID: <20060314153455.GA8071@suse.de>
References: <F331B95B72AFFB4B87467BE1C8E9CF5F36D829@NAMAIL2.ad.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F331B95B72AFFB4B87467BE1C8E9CF5F36D829@NAMAIL2.ad.lsil.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2006 at 05:52:40PM -0700, Moore, Eric wrote:
> Request for exporting device_reprobe - 
> 
> Adding support for exposing hidden raid components 
> for sg interface. The sdev->no_uld_attach flag
> will set set accordingly.
> 
> The sas module supports adding/removing raid
> volumes using online storage management application
> interface.  
> 
> This patch was provided to me by Christoph Hellwig.
> 
> Signed-off-by: Eric Moore <Eric.Moore@lsil.com>

base64 for the attachment with DOS line ends?  ugh, can you please fix
this up and resend?

Also, it looks like USB needs to call this function, (based on the
comment)?  Care to switch that code over to have it use it too?

thanks,

greg k-h
