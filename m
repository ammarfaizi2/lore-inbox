Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752012AbWFWUFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbWFWUFv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 16:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbWFWUFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 16:05:51 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:40911 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751967AbWFWUFu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 16:05:50 -0400
Date: Fri, 23 Jun 2006 22:05:41 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Al Viro <viro@ftp.linux.org.uk>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Finn Thain <fthain@telegraphics.com.au>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: [PATCH 08/21] gcc 4 fix
In-Reply-To: <20060623193524.GA27946@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0606232158400.17704@scrub.home>
References: <20060623183056.479024000@linux-m68k.org> <20060623183911.847605000@linux-m68k.org>
 <20060623193524.GA27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 23 Jun 2006, Al Viro wrote:

> On Fri, Jun 23, 2006 at 08:31:04PM +0200, zippel@linux-m68k.org wrote:
> > Fixes a "static qualifier follows non-static qualifier" error from gcc 4.
> > 
> > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> > Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
> 
> Broken.  Proper fix is to rename the function so that it wouldn't clash.

Well, I wouldn't call it broken, as both versions can never be compiled 
into the same kernel, but I don't care much how it's fixed.

Does anyone know the relationship between via-pmu.c and via-pmu68k.c? If 
it's intended to keep the differences small, a rename would be the wrong 
fix.

bye, Roman
