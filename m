Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266492AbUBRX1x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 18:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266526AbUBRX10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 18:27:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:55168 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266492AbUBRX0H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 18:26:07 -0500
Date: Wed, 18 Feb 2004 15:27:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: thornber@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm1
Message-Id: <20040218152745.766ede4c.akpm@osdl.org>
In-Reply-To: <20040219125219.54978b4e.ak@suse.de>
References: <20040217232130.61667965.akpm@osdl.org.suse.lists.linux.kernel>
	<p73wu6k653f.fsf@verdi.suse.de>
	<20040218025549.4e7c56a1.akpm@osdl.org>
	<20040219073734.309e396d.ak@suse.de>
	<20040218134558.GN27549@reti>
	<20040219125219.54978b4e.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> On Wed, 18 Feb 2004 13:45:58 +0000
> Joe Thornber <thornber@redhat.com> wrote:
> 
> > On Thu, Feb 19, 2004 at 07:37:34AM +0100, Andi Kleen wrote:
> > > Supporting metadata can be quite simple - e.g. a standard header on the first blocks that
> > > has a length and a number of records with unique IDs. And the kernel driver would need
> > > to skip over these headers.
> > 
> > The target already takes an offset into the device, so you have what you want.
> 
> Ok fine. The only requirement would be compatible IVs then.
> 

Would it be correct to say that until someone does this development,
dm-crypt has the same vulnerabilities as cryptoloop?  Or is there some
different way of using dm-crypt which is incompatible with cryptoloop, but
is more secure?

