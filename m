Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270053AbRHGDvB>; Mon, 6 Aug 2001 23:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270055AbRHGDuv>; Mon, 6 Aug 2001 23:50:51 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:22288 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S270053AbRHGDuh>;
	Mon, 6 Aug 2001 23:50:37 -0400
Date: Mon, 6 Aug 2001 23:47:09 -0400
From: Anton Blanchard <anton@samba.org>
To: Kai Henningsen <kaih@khms.westfalen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PPC? (Was: Re: [RFC] /proc/ksyms change for IA64)
Message-ID: <20010806234709.E11858@krispykreme>
In-Reply-To: <22165.996722560@kao2.melbourne.sgi.com> <86HgALWHw-B@khms.westfalen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86HgALWHw-B@khms.westfalen.de>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> > The IA64 use of descriptors for function pointers has bitten ksymoops.
> > For those not familiar with IA64, &func points to a descriptor
> > containing { &code, &data_context }.
> 
> That sounds suspiciously like what I remember from PPC. How is this solved  
> on the PPC side?

This isnt the case on ppc32, but is at the moment on ppc64.

Anton
