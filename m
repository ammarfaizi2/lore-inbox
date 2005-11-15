Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbVKORjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbVKORjq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 12:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbVKORjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 12:39:46 -0500
Received: from mail.kroah.org ([69.55.234.183]:38045 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751459AbVKORjq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 12:39:46 -0500
Date: Tue, 15 Nov 2005 09:25:28 -0800
From: Greg KH <greg@kroah.com>
To: Doug Thompson <norsk5@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] EDAC and the sysfs
Message-ID: <20051115172528.GB13658@kroah.com>
References: <20051114223105.GA5868@kroah.com> <20051115004704.91557.qmail@web50106.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051115004704.91557.qmail@web50106.mail.yahoo.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2005 at 04:47:03PM -0800, Doug Thompson wrote:
> For each Chip-Select Row (csrow) there would be
> information. I am still trying to determine if each
> csrow would be in its own directory or all cwrows just
> flat in the mc0, mc1, ... directories. 
> 
> Assuming each csrow is in its own directory (which is
> the way I am leaning) below:
> 
> csrow0/
> csrow1/
> csrow2/
> csrow3/
> ...
> 
> info files in the above directories:
> 
> memory_size
> memory_type
> device_type
> edac_mode
> ue_count
> ce_count
> ce_count_channel_0
> ce_count_channel_1
> dimm_label
> dimm_label_channel_0
> dimm_label_channel_1
> 

Ok, thanks for the details, it makes more sense now.  Your heirachy
seems sane, have you implemented it to see if it works properly?

thanks,

greg k-h
