Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265248AbTFEXt2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 19:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265258AbTFEXt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 19:49:28 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:52951 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S265248AbTFEXt1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 19:49:27 -0400
Date: Thu, 05 Jun 2003 17:03:35 -0700
From: Hanna Linder <hannal@us.ibm.com>
Reply-To: Hanna Linder <hannal@us.ibm.com>
To: viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@digeo.com>
cc: Pavel Machek <pavel@suse.cz>, mochel@osdl.org, greg@kroah.com,
       hannal@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [RFT/C 2.5.70] Input class hook up to driver model/sysfs
Message-ID: <26710000.1054857815@w-hlinder>
In-Reply-To: <20030605234150.GY6754@parcelfarce.linux.theplanet.co.uk>
References: <20030605220716.GF608@elf.ucw.cz> <Pine.LNX.4.44.0306051511350.13077-100000@cherise> <20030605224535.GH608@elf.ucw.cz> <20030605155642.68179245.akpm@digeo.com> <20030605234150.GY6754@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Friday, June 06, 2003 12:41:50 AM +0100 viro@parcelfarce.linux.theplanet.co.uk wrote:

> 
> It doesn't - note the absense of ->release() in the introduced objects,

Well... The ->release() part didnt exist when I sent out this patch.
I understand this original attempt had some problems.

> zombies ("I want it gone, but sysfs holds it") and when that is
> done - have freeing done from ->release() of kobject.
>

Yup. That is the plan. I will be fully compliant in following the
agreed-to sysification solution ;)

Thanks.

Hanna


