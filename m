Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263475AbUFJXnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbUFJXnH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 19:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263457AbUFJXnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 19:43:07 -0400
Received: from fire.osdl.org ([65.172.181.4]:14469 "EHLO fire-2.osdl.org")
	by vger.kernel.org with ESMTP id S263551AbUFJXme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 19:42:34 -0400
Subject: Re: sparse in compile stats
From: John Cherry <cherry@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20040606191830.GB2788@mars.ravnborg.org>
References: <20040606191830.GB2788@mars.ravnborg.org>
Content-Type: text/plain
Message-Id: <1086910938.5884.79.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 10 Jun 2004 16:42:18 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam,

I am doing sparse runs now on all of linus' and andrew's kernels.  Since
sparse is changing along with the kernel, comparing to older versions
will not buy us much right now.  As sparse stabalizes, perhaps this
would be an option.

For the sparse runs, I am building with allmodconfig (bzImage and
modules).

John

On Sun, 2004-06-06 at 12:18, Sam Ravnborg wrote:
> Hi John.
> 
> Recently Al Viro has put in a huge effort into sparse sanitize the kernel,
> and likewise Linus has done several updates to sparse.
> Net result is a _lot_ of sparse warnings removed, and very few (if any?) false positives.
> 
> Do you think it is worth to include a sparse run when Linus does next -rc?
> Comparing with older versions should only be for amusement, since Al and Linus did
> such a big effor the last weeks.
> 
> 	Sam

