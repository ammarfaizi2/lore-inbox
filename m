Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263028AbVAFVdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263028AbVAFVdx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 16:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263017AbVAFV0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 16:26:47 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:47753 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263039AbVAFVZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 16:25:09 -0500
Date: Thu, 6 Jan 2005 11:46:46 -0800
From: Greg KH <greg@kroah.com>
To: "Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Ladislav Michl <ladis@linux-mips.org>,
       linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com,
       linux-mips@linux-mips.org
Subject: Re: [2.6 patch] 2.6.10-mm2: let I2C_ALGO_SGI depend on MIPS
Message-ID: <20050106194646.GB5481@kroah.com>
References: <20050106002240.00ac4611.akpm@osdl.org> <20050106181519.GG3096@stusta.de> <20050106192701.GA13955@linux-mips.org> <41DD9313.4030105@total-knowledge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DD9313.4030105@total-knowledge.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 11:35:47AM -0800, Ilya A. Volynets-Evenbakh wrote:
> Ralf Baechle wrote:
> 
> >On Thu, Jan 06, 2005 at 07:15:20PM +0100, Adrian Bunk wrote:
> >
> > 
> >
> >>There's no reason for offering a MIPS-only driver on other architectures 
> >>(even though it does compile).
> >>
> >>Even better dependencies on specific MIPS variables might be possible 
> >>that obsolete this patch, but this patch fixes at least the !MIPS case.
> >>   
> >>
> >
> >Please make that depend on SGI_IP22 || SGI_IP32 instead; the only machines
> >actually using it.
> >
> >Ladis, is VisWS using this algo also?
> > 
> >
> Since MACE is common part, it most likely does.

Ok, can someone send me the proper patch then?

thanks,

greg k-h
