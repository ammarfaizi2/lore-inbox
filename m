Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbWDHTmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWDHTmW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 15:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWDHTmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 15:42:22 -0400
Received: from mail.gmx.de ([213.165.64.20]:17114 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751412AbWDHTmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 15:42:21 -0400
X-Authenticated: #20450766
Date: Sat, 8 Apr 2006 21:42:25 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Andi Kleen <ak@suse.de>
cc: James Courtier-Dutton <James@superbug.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: Black box flight recorder for Linux
In-Reply-To: <p73odzc9ocx.fsf@bragg.suse.de>
Message-ID: <Pine.LNX.4.60.0604082141350.3811@poirot.grange>
References: <44379AB8.6050808@superbug.co.uk> <p73odzc9ocx.fsf@bragg.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Apr 2006, Andi Kleen wrote:

> James Courtier-Dutton <James@superbug.co.uk> writes:
> > 
> > Now, the question I have is, if I write values to RAM, do any of those
> > values survive a reset?
> 
> They don't generally.
> 
> Some people used to write the oopses into video memory, but that
> is not portable.

Some even write them to mtd (NOR flash), but that is even less portable:-)

Thanks
Guennadi
---
Guennadi Liakhovetski
