Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbTKYRbl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 12:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262848AbTKYRbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 12:31:41 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:54209 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262844AbTKYRbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 12:31:35 -0500
From: Kevin Corry <kevcorry@us.ibm.com>
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Subject: Re: [Patch 3/5] dm: make v4 of the ioctl interface the default
Date: Tue, 25 Nov 2003 11:28:04 -0600
User-Agent: KMail/1.5
Cc: Joe Thornber <thornber@sistina.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@osdl.org>
References: <20031125162451.GA524@reti> <200311251109.07831.kevcorry@us.ibm.com> <3FC38E85.1020100@backtobasicsmgmt.com>
In-Reply-To: <3FC38E85.1020100@backtobasicsmgmt.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311251128.04443.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 November 2003 11:16, Kevin P. Fleming wrote:
> Kevin Corry wrote:
>
>   	---help---
> -	  Recent tools use a new version of the ioctl interface, only
> -          select this option if you intend using such tools.
> +	  Recent tools use this new version of the ioctl interface. Only
> +	  select N for this option if you use out-of-date tools that weren't
> +	  compiled for this interface (e.g. LVM2 prior to v2.00.00).
>
> Actually, I don't think LVM2 uses the device mapper ioctls at all; it
> use libdevmapper which calls the ioctls on its behalf.

True. I imagine Joe will know the exact version numbers of LVM2 and 
libdevmapper that require the old interface. I believe the version I 
mentioned is from the appropriate time-frame, though.

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/

