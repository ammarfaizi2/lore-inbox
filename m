Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbVADVEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbVADVEn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 16:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbVADVEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 16:04:36 -0500
Received: from waste.org ([216.27.176.166]:9125 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261700AbVADVEA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 16:04:00 -0500
Date: Tue, 4 Jan 2005 13:03:43 -0800
From: Matt Mackall <mpm@selenic.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: domen@coderock.org, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 6/6] delete unused file
Message-ID: <20050104210342.GA2995@waste.org>
References: <20041226153257.0F3501F126@trashy.coderock.org> <1104081178.15994.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104081178.15994.11.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2004 at 05:13:00PM +0000, Alan Cox wrote:
> On Sul, 2004-12-26 at 15:33, domen@coderock.org wrote:
> > Remove nowhere referenced file. (egrep "filename\." didn't find anything)
> 
> This file is there for a reason - it completes the set of endian types
> should anyone port to a mixed endian system.

Please name one such box that doesn't support a more sensible order
and is vaguely Linux-capable. The PDP-11 does not qualify, as it's
only 16-bit and could be made to DTRT for 32-bit values in the
compiler if you were going to go to the trouble of making "int" and
"void *" 32 bits on a 16-bit arch and then trying to fit the
resulting bloated code in the 4MB the later PDP-11s supported.

This file is silly.

-- 
Mathematics is the supreme nostalgia of our time.
