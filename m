Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262316AbVBQRnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbVBQRnP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 12:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbVBQRnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 12:43:14 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:36578 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262316AbVBQRnJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 12:43:09 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] quiet non-x86 option ROM warnings
Date: Thu, 17 Feb 2005 09:41:22 -0800
User-Agent: KMail/1.7.2
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200502151557.06049.jbarnes@sgi.com> <200502170929.54100.jbarnes@sgi.com> <9e47339105021709321dc72ab2@mail.gmail.com>
In-Reply-To: <9e47339105021709321dc72ab2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502170941.22802.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, February 17, 2005 9:32 am, Jon Smirl wrote:
> > Shouldn't it return NULL if the signature is invalid?
>
> But then you couldn't get to your non-standard ROMs

Ok, I'll fix up the callers then.

Jesse
