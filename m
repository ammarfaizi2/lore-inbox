Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbVADJVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbVADJVA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 04:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVADJVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 04:21:00 -0500
Received: from open.hands.com ([195.224.53.39]:55177 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S261569AbVADJU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 04:20:56 -0500
Date: Tue, 4 Jan 2005 09:30:44 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Adam Heath <doogie@brainfood.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "xen-devel@lists.sf.net" <xen-devel@lists.sf.net>
Subject: Re: [Xen-devel] Re: [XEN] using shmfs for swapspace
Message-ID: <20050104093044.GC10906@lkcl.net>
References: <20050102162652.GA12268@lkcl.net> <20050103183133.GA19081@samarkand.rivenstone.net> <20050103205318.GD6631@lkcl.net> <Pine.LNX.4.58.0501031506080.21792@gradall.private.brainfood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501031506080.21792@gradall.private.brainfood.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 03:07:42PM -0600, Adam Heath wrote:

> >  so this tends to suggest a strategy where you allocate as
> >  much memory as you can afford to the DOM0 VM, and as little
> >  as you can afford to the guests, and make the guest swap
> >  files bigger to compensate.
> 
> But the guest kernels need real ram to run programs in.
> 
> The problem with dom0 doing the caching, is that dom0 has no idea about the
> usage pattern for the swap.  It's just a plain file to dom0.  Only each guest
> kernel knows how to combine swap reads/writes correctly.

... hmm...

then that tends to suggest that this is an issue that should
really be dealt with by XEN.

that there needs to be coordination of swap management between the
virtual machines.

l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--
