Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264449AbTIIVTz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 17:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264434AbTIIVTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 17:19:33 -0400
Received: from zok.SGI.COM ([204.94.215.101]:1463 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S264449AbTIIVSM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 17:18:12 -0400
Date: Tue, 9 Sep 2003 14:17:56 -0700
To: Andrew de Quincey <adq@lidskialf.net>
Cc: andrew.grover@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] deal with lack of acpi prt entries gracefully
Message-ID: <20030909211756.GA7487@sgi.com>
Mail-Followup-To: Andrew de Quincey <adq@lidskialf.net>,
	andrew.grover@intel.com, linux-kernel@vger.kernel.org
References: <20030909201310.GB6949@sgi.com> <200309092143.58189.adq@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309092143.58189.adq@lidskialf.net>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 09:43:58PM +0100, Andrew de Quincey wrote:
> On Tuesday 09 September 2003 21:13, Jesse Barnes wrote:
> > Instead of going into an infinite loop because the list isn't setup yet,
> > just return NULL if there are no prt entries.
> 
> Ah, this is a patch against the vanilla kernel.. This is unfortunately 
> incompatible with my recent ACPI patches.

Maybe you could include it in your patch then?  I noticed that your
patch changes some of the IRQ routing code...

Thanks,
Jesse
