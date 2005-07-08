Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262781AbVGHTff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262781AbVGHTff (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 15:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262799AbVGHTdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 15:33:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:52191 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262781AbVGHTbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 15:31:06 -0400
Date: Fri, 8 Jul 2005 21:31:05 +0200
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: ak@suse.de, Adnan.Khaleel@newisys.com, linux-kernel@vger.kernel.org
Subject: Re: Instruction Tracing for Linux
Message-ID: <20050708193105.GT21330@wotan.suse.de>
References: <DC392CA07E5A5746837A411B4CA2B713010D7790@sekhmet.ad.newisys.com.suse.lists.linux.kernel> <p738y0hp0zc.fsf@verdi.suse.de> <20050708.122334.66180889.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050708.122334.66180889.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2005 at 12:23:34PM -0700, David S. Miller wrote:
> From: Andi Kleen <ak@suse.de>
> Date: 08 Jul 2005 21:11:03 +0200
> 
> > While some CPUs (like Intel P4) have ways to do such hardware
> > tracing I know of no free tool that uses it. There are some user
> > space tools to collect at user space, but they probably won't help you.
> 
> FWIW, even without explicit tracing support in the CPU it
> is possible to get these kinds of traces nontheless.

x86 has single step by default, but doing full tracing with that 
would be difficult and slow. With the simulators it is really
easy though - i used that extensively while bringing up x86-64.

-Andi

