Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266970AbSLDRsc>; Wed, 4 Dec 2002 12:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266972AbSLDRsc>; Wed, 4 Dec 2002 12:48:32 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:1805 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266970AbSLDRsb>;
	Wed, 4 Dec 2002 12:48:31 -0500
Date: Wed, 4 Dec 2002 09:56:03 -0800
From: Greg KH <greg@kroah.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [BKPATCH] bus notifiers for the generic device model
Message-ID: <20021204175602.GC27780@kroah.com>
References: <200212041709.gB4H9LA02808@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212041709.gB4H9LA02808@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 11:09:21AM -0600, James Bottomley wrote:
> There are certain bus types (notably MCA and parisc internal ones) that like 
> to do generic houskeeping operations (claim slots, claim uniform resources 
> etc.) when drivers are attached to devices.

But doesn't the bus specific core know when drivers are attached, as it
was told to register or unregister a specific driver?  So I don't see
why this is really needed.

thanks,

greg k-h
