Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbTEaJdz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 05:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264264AbTEaJdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 05:33:54 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:12809 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264261AbTEaJdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 05:33:54 -0400
Date: Sat, 31 May 2003 10:47:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: must-fix, version 6
Message-ID: <20030531104714.A28147@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <20030530163720.399a8bac.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030530163720.399a8bac.akpm@digeo.com>; from akpm@digeo.com on Fri, May 30, 2003 at 04:37:20PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 30, 2003 at 04:37:20PM -0700, Andrew Morton wrote:
> +  PRI3
> +
>  o 32bit quota needs a lot more testing but may work now
>  
> +  PRI2

I think we can remove this.  It's shipped with the vendor trees, -ac
and the XFS tree for a while now and got a fair amount of testing.

>  o IDE requires bio walking
>  
>    "Bartlomiej has IDE multisector working" (does that mean it's fixed?)
>  
> +  PRI1

bio walking seems to be in now.

> +o new zfcp fibre channel driver
> +
> +  PRI3

Is there a 2.5 patch of this somewhere?

