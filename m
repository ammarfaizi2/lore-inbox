Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271707AbTG2NCt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 09:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271710AbTG2NCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 09:02:48 -0400
Received: from dialpool-210-214-82-140.maa.sify.net ([210.214.82.140]:47753
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S271707AbTG2NCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 09:02:47 -0400
Date: Tue, 29 Jul 2003 18:34:00 +0530
From: Balram Adlakha <b_adlakha@softhome.net>
To: Wakko Warner <wakko@animx.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 NFS file transfer
Message-ID: <20030729130400.GA4052@localhost.localdomain>
References: <20030728225947.GA1694@localhost.localdomain> <20030729072440.A12426@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030729072440.A12426@animx.eu.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 29, 2003 at 07:24:40AM -0400, Wakko Warner wrote:
> > I cannot transfer files larger than 914 mb from an NFS mounted
> > filesystem to a local filesystem. A larger file than that is
> > simply cut of at 914 MB. This is using 2.6.0-test1, 2.4.20 
> > works fine. Can it be the version of mount I'm using? Its the
> > one that comes with util-linux-2.11y.
> 
> I noticed on 2.6.0-test1 that mounting a server using the userspace nfs
> daemon (v2 I assume) doesn't work very well at all.  It was pretty much
> useless.  I rarely ever could get a directory listing.  It would just spew
> "nfs server not responding".
> 
> -- 
>  Lab tests show that use of micro$oft causes cancer in lab animals

I'll try with the kernel NFS then, any idea why this happens?
