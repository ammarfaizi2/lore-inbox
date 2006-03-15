Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWCOBwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWCOBwc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 20:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbWCOBwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 20:52:32 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:63326 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932245AbWCOBwb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 20:52:31 -0500
Date: Wed, 15 Mar 2006 03:52:26 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Olof Johansson <olof@lixom.net>
Cc: Jon Mason <jdmason@us.ibm.com>, Pavel Machek <pavel@suse.cz>,
       Muli Ben-Yehuda <mulix@mulix.org>, Andi Kleen <ak@suse.de>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH RFC 2/3] x86-64: Calgary IOMMU - Calgary specific bits
Message-ID: <20060315015226.GD725@rhun.zurich.ibm.com>
References: <20060314082432.GE23631@granada.merseine.nu> <20060314082552.GF23631@granada.merseine.nu> <20060314230306.GB1579@elf.ucw.cz> <20060315005514.GD7699@us.ibm.com> <20060315005632.GE5170@pb15.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060315005632.GE5170@pb15.lixom.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2006 at 06:56:32PM -0600, Olof Johansson wrote:

> We're killing structures like that one by one on PPC, I just haven't
> gotten around to dealing with tce_entry yet.
> 
> The way to do it is to use masking and shifting by hand.

I actually wrote it that way and compared with the bitmapped TCE at
run time to convince myself the bitmap version is doing the right
thing (it does). Then I kept the bitmap version since if that's what
PPC does, it can't be bad :-)

Will fix.

Cheers,
Muli

