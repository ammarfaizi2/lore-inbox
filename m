Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265261AbUGCVXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265261AbUGCVXj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 17:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265266AbUGCVXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 17:23:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57758 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265261AbUGCVXi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 17:23:38 -0400
Date: Sat, 3 Jul 2004 18:04:27 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: "Marcelo W. Tosatti" <marcelo.tosatti@cyclades.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] building linux-2.4 with gcc 3.3.3
Message-ID: <20040703210427.GC13076@logos.cnet>
References: <20040629153452.5a03ab5e@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040629153452.5a03ab5e@dell_ss3.pdx.osdl.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2004 at 03:34:52PM -0700, Stephen Hemminger wrote:
> It appears linux-2.4 won't build with gcc 3.3.3 (SuSe) because it is picky about
> the attributes matching the prototype which shows up on the FASTCALL() usage.

Right, I think its OK to incorporate Mikael's gcc-3.4.0 fixes in 2.4.28-pre1, 
which already include the fastcall fixes:

http://user.it.uu.se/~mikpe/linux/patches/2.4/patch-gcc340-fixes-2.4.27-rc2

I had a couple of doubts about it and asked Mikael privately, but no big deal.
