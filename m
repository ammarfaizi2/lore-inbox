Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266072AbUBKUMI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 15:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266099AbUBKUMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 15:12:08 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:1704 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S266072AbUBKUMB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 15:12:01 -0500
Date: Wed, 11 Feb 2004 12:11:20 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: Willem Riede <wrlk@riede.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Selective attach for ide-scsi
Message-ID: <20040211121120.A24289@beaverton.ibm.com>
References: <20040208224248.GA28026@serve.riede.org> <16423.17315.777835.128816@alkaid.it.uu.se> <20040210000205.GG28026@serve.riede.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040210000205.GG28026@serve.riede.org>; from wrlk@riede.org on Mon, Feb 09, 2004 at 07:02:05PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 09, 2004 at 07:02:05PM -0500, Willem Riede wrote:
> On 2004.02.09 03:24, Mikael Pettersson wrote:
> > Willem Riede writes:

> > The patch I posted, which you apparently didn't like, doesn't
> > require the use of boot-only options: it instead adds a module_param
> > to ide-scsi which allows for greater flexibility.
> > 
> > Personally I never liked that butt-ugly hdX=ide-scsi hack.
> 
> I hear you. There are certainly advantages to use a module parameter rather
> than a boot argument.

But module_param allows module arguments when built as a module, and boot
arguments when built into the kernel.

> However, there should not be two mechanisms to achieve the same goal. For
> better or for worse, the hdX=<driver> construction exists, and people are
> using it. Its use is not limited to ide-scsi.

So does module_param not work because the usage is across modules? That
seems odd.

-- Patrick Mansfield
