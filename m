Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVALS5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVALS5L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 13:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVALS4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 13:56:44 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:25029 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261280AbVALSzQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 13:55:16 -0500
Date: Wed, 12 Jan 2005 10:55:13 -0800
From: Greg KH <greg@kroah.com>
To: Justin Thiessen <jthiessen@penguincomputing.com>
Cc: LM Sensors <sensors@Stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>, khali@linux-fr.org
Subject: Re: PATCH (take 3) for adm1026.c, kernel 2.6.10-bk14
Message-ID: <20050112185513.GB10687@kroah.com>
References: <41D5D075.4000200@paradyne.com> <20050101001205.6b2a44d3.khali@linux-fr.org> <20050103194355.GA11979@penguincomputing.com> <20050103201056.3c55e330.khali@linux-fr.org> <20050103213707.GA12765@penguincomputing.com> <20050103205231.GK9923@schnapps.adilger.int> <20050103221249.GB12765@penguincomputing.com> <20050112185055.GB16724@penguincomputing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112185055.GB16724@penguincomputing.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 10:50:55AM -0800, Justin Thiessen wrote:
> Ok, take 3 on the adm1026 patch.
> 
> In this patch:
> 
> (1) Code has been added which ensures that the fan divisor registers are 
>     properly read into the data structure before fan minimum speeds are 
>     determined.  This prevents a possible divide by zero error.  The line 
>     which reads the hardware default fan divisor values has been reformatted 
>     as suggested by Andreas Dilger to make the intent of the statement clearer.
> 
> (2) In a similar spirit, an unecessary carriage return from a "dev_dbg" 
>     statement in the adm1026_print_gpio() function has been elminated,
>     shortening the statement to a single line and making the code easier
>     to read.
> 
> Signed-off-by: Justin Thiessen <jthiessen@penguincomputing.com

Applied, thanks.

greg k-h
