Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266948AbUBRNl6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 08:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267012AbUBRNl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 08:41:58 -0500
Received: from intra.cyclades.com ([64.186.161.6]:54411 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S266948AbUBRNl0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 08:41:26 -0500
Date: Wed, 18 Feb 2004 11:34:54 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Willy Tarreau <willy@w.ods.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.25-rc4
In-Reply-To: <20040218055744.GC15660@alpha.home.local>
Message-ID: <Pine.LNX.4.58L.0402181132480.4852@logos.cnet>
References: <Pine.LNX.4.58L.0402180207540.4852@logos.cnet>
 <20040218055744.GC15660@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Feb 2004, Willy Tarreau wrote:

> Hi Marcelo,
>
> On Wed, Feb 18, 2004 at 02:11:24AM -0300, Marcelo Tosatti wrote:
> > Here goes release candidate 4, including a few small fixes.
> >
> > If nothing bad shows up, this will become final.
>
> Well, I would have liked to see the ACPI poweroff fix I sent a few days ago,
> but Len said he doesn't have time to review it this week. It's a shame since
> at least two of my machines which powered off correctly with very older ACPI
> versions now need it, so I don't think I'm the only one in this case :-(
>
> Other than that, I'm fairly happy with at least -rc2 (not tested latest
> releases yet).

Hi Willy,

Your fix looks ok. I dont think calling acpi_system_save_state(S5) can
cause any breakage. Len?

We can test the patch in 2.4.26-pre1.

Thanks
