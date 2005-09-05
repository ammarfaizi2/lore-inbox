Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbVIEOOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbVIEOOL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 10:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbVIEOOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 10:14:11 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:35212 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1751236AbVIEOOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 10:14:10 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [ATMSAR] Request for review - update #1
Date: Mon, 5 Sep 2005 15:18:24 +0100
User-Agent: KMail/1.8.90
Cc: Giampaolo Tomassoni <g.tomassoni@libero.it>, linux-kernel@vger.kernel.org,
       linux-atm-general@lists.sourceforge.net
References: <NBBBIHMOBLOHKCGIMJMDGEHPEKAA.g.tomassoni@libero.it> <200509051452.21075.s0348365@sms.ed.ac.uk> <1125928580.29448.33.camel@hades.cambridge.redhat.com>
In-Reply-To: <1125928580.29448.33.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509051518.24966.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 September 2005 14:56, David Woodhouse wrote:
> On Mon, 2005-09-05 at 14:52 +0100, Alistair John Strachan wrote:
> > I'm not sure which module you're referring to, but the patch recommended
> > by the speedtouch people links to linux-atm, and does not require kernel
> > ATM or kernel pppoatm functionality, or use any kernel modules. I do
> > notice it does a system ("/sbin/modprobe pppoatm"); but this is
> > definitely not required; I'm speaking to you from a speedtouch DSL
> > connection, no module loaded or compiled in, no ATM support in the
> > kernel.
>
> Then you're not using the pppoatm plugin; you needn't bother applying
> that patch. You're probably just using the pseudo-tty hack.

Ahh yes, I was confusing the pppd module with pppoa3, a userspace ppp-over-atm 
handler. Thanks for the correction.

Still, I don't feel this detracts from the point that client ATM DSL device 
"drivers" can exist happily in userspace.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
