Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262053AbVBKJPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbVBKJPf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 04:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbVBKJPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 04:15:35 -0500
Received: from sd291.sivit.org ([194.146.225.122]:2182 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262053AbVBKJPQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 04:15:16 -0500
Date: Fri, 11 Feb 2005 10:16:46 +0100
From: Stelian Pop <stelian@popies.net>
To: Bruno Ducrot <ducrot@poupinou.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] [PATCH, new ACPI driver] new sony_acpi driver
Message-ID: <20050211091645.GD3263@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Bruno Ducrot <ducrot@poupinou.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, acpi-devel@lists.sourceforge.net
References: <20050210161809.GK3493@crusoe.alcove-fr> <20050210193937.GH1145@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050210193937.GH1145@poupinou.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2005 at 08:39:37PM +0100, Bruno Ducrot wrote:

> On Thu, Feb 10, 2005 at 05:18:10PM +0100, Stelian Pop wrote:
> > Hi,
> > 
> > +ACPI Sony Notebook Control Driver (SNC) Readme
> > +----------------------------------------------
> > +	Copyright (C) 2004 Stelian Pop <stelian@popies.net>
> > +
> > +This mini-driver drives the ACPI SNC device present in the 
> > +ACPI BIOS of the Sony Vaio laptops.
> > +
> > +It gives access to some extra laptop functionalities. In 
> > +its current form, the only thing this driver does is letting
> > +the user set or query the screen brightness.
> 
> Does those laptops support acpi_video?

No. I double checked for a few AML dumps I have here, and except
for _DOS/_DOD present in some of them no other acpi_video method is
supported.

Newer Vaio laptops may eventualy support acpi_video, but all
current (to the best of my knowledge) Vaios do support the SNC device.

Stelian.
-- 
Stelian Pop <stelian@popies.net>
