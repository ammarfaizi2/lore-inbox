Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWJPNIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWJPNIc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 09:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWJPNIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 09:08:32 -0400
Received: from twin.jikos.cz ([213.151.79.26]:9671 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1750758AbWJPNIb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 09:08:31 -0400
Date: Mon, 16 Oct 2006 15:08:11 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Jan Beulich <jbeulich@novell.com>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: dwarf2 stuck Re: lockdep warning in i2c_transfer() with dibx000
 DVB - input tree merge plans?
In-Reply-To: <45339E57.76E4.0078.0@novell.com>
Message-ID: <Pine.LNX.4.64.0610161506570.29022@twin.jikos.cz>
References: <Pine.LNX.4.64.0610121521390.29022@twin.jikos.cz>
 <200610161231.30705.ak@suse.de> <4533991C.76E4.0078.0@novell.com>
 <Pine.LNX.4.64.0610161443010.29022@twin.jikos.cz> <45339E57.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2006, Jan Beulich wrote:

> >Yes, it was compiled using gcc 4.0.2, specifically gcc (GCC) 4.0.2 
> >20051125 (Red Hat 4.0.2-8). I can easily reproduce this, what 
> >additional information do you need? Or should I just try with newer 
> >gcc?
> Two possible paths:
> a) Try with gcc 4.1.x.

Will do probably later today.

> b) Send me the offending .o (presumably the one containing 
> dibusb_dib3000mc_tuner_attach)

You can get it from http://www.jikos.cz/jikos/junk/dibusb-common.o

-- 
Jiri Kosina
