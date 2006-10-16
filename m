Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWJPM6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWJPM6R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 08:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWJPM6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 08:58:17 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:49034 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1750706AbWJPM6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 08:58:16 -0400
Message-Id: <45339E57.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Mon, 16 Oct 2006 14:59:35 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Jiri Kosina" <jikos@jikos.cz>
Cc: "Andi Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: dwarf2 stuck Re: lockdep warning in i2c_transfer() with
	dibx000 DVB - input tree merge plans?
References: <Pine.LNX.4.64.0610121521390.29022@twin.jikos.cz>
 <200610161231.30705.ak@suse.de> <4533991C.76E4.0078.0@novell.com>
 <Pine.LNX.4.64.0610161443010.29022@twin.jikos.cz>
In-Reply-To: <Pine.LNX.4.64.0610161443010.29022@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Yes, it was compiled using gcc 4.0.2, specifically gcc (GCC) 4.0.2 
>20051125 (Red Hat 4.0.2-8). I can easily reproduce this, what additional 
>information do you need? Or should I just try with newer gcc?

Two possible paths:
a) Try with gcc 4.1.x.
b) Send me the offending .o (presumably the one containing dibusb_dib3000mc_tuner_attach)

Jan
