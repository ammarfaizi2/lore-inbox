Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287591AbSA1NEm>; Mon, 28 Jan 2002 08:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287866AbSA1NEc>; Mon, 28 Jan 2002 08:04:32 -0500
Received: from ns.ithnet.com ([217.64.64.10]:46599 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S287591AbSA1NEZ>;
	Mon, 28 Jan 2002 08:04:25 -0500
Date: Mon, 28 Jan 2002 14:03:49 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Thomas Hood <jdthood@mail.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        sfr@canb.auug.org.au
Subject: Re: 2.4.18-pre7 slow ... apm problem
Message-Id: <20020128140349.22b5e030.skraw@ithnet.com>
In-Reply-To: <1012217107.746.5.camel@thanatos>
In-Reply-To: <E16V8oV-0004FV-00@the-village.bc.nu>
	<1012217107.746.5.camel@thanatos>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Jan 2002 06:25:05 -0500
Thomas Hood <jdthood@mail.com> wrote:

> On Mon, 2002-01-28 at 05:14, Alan Cox wrote:
> > If so then I suspect vmware should be issuing APM cpu busy calls itself
> 
> Do you see a difference between VMware and other processes
> in their susceptibility to this problem?  If VMware runs
> slowly because it gets scheduled in while the CPU is idle
> and the apm driver fails to busyize the CPU, won't the same
> thing happen for other processes?  If so, then our idle 
> handling is fundamentally broken.  If not, then what makes
> VMware special?

Maybe it's just broken. I have some strange problems with hanging vmware 3
(reproducable) on a SMP machine. On an equal machine vmware 2 runs 
flawlessly. There is no APM or the like involved, both under 2.4.18-pre7.
I just don't trust it.

Regards,
Stephan


