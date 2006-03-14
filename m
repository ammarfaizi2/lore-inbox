Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751782AbWCNPgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782AbWCNPgW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 10:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751836AbWCNPgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 10:36:22 -0500
Received: from mail.kroah.org ([69.55.234.183]:47291 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751782AbWCNPgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 10:36:21 -0500
Date: Tue, 14 Mar 2006 07:35:24 -0800
From: Greg KH <gregkh@suse.de>
To: "Moore, Eric" <Eric.Moore@lsil.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       James.Bottomley@SteelEye.com, hch@lst.de
Subject: Re: [PATCH ] drivers/scsi/scsi.c - export reprobe
Message-ID: <20060314153524.GB8071@suse.de>
References: <F331B95B72AFFB4B87467BE1C8E9CF5F36D82A@NAMAIL2.ad.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F331B95B72AFFB4B87467BE1C8E9CF5F36D82A@NAMAIL2.ad.lsil.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2006 at 05:52:43PM -0700, Moore, Eric wrote:
> Request for exporting device_reprobe - 
> This is scsi wrapper portion.

Is this even really needed?  It's just a single pointer dereference...

thanks,

greg k-h
