Return-Path: <linux-kernel-owner+w=401wt.eu-S1762792AbWLKLUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762792AbWLKLUX (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 06:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762817AbWLKLUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 06:20:23 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39256 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762792AbWLKLUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 06:20:22 -0500
Date: Mon, 11 Dec 2006 11:20:17 +0000
From: Christoph Hellwig <hch@infradead.org>
To: linuxppc-dev@ozlabs.org, paulus@samba.org, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org
Subject: Re: powerpc: "IRQ probe failed (0x0)" on powerbook
Message-ID: <20061211112017.GA16399@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linuxppc-dev@ozlabs.org, paulus@samba.org, benh@kernel.crashing.org,
	linux-kernel@vger.kernel.org
References: <87lklg9rkz.fsf@briny.internal.ondioline.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lklg9rkz.fsf@briny.internal.ondioline.org>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2006 at 07:45:48PM +1300, Paul Collins wrote:
> On my PowerBook when booting Linus's tree as of commit af1713e0 I get
> something like this:
> 
>   [blah blah]
>   ide0: Found Apple UniNorth ATA-6 controller, bus ID 3, irq 0
>   Probing IDE interface ide0...
>   hda: HTS541080G9AT00, ATA DISK drive
>   IRQ probe failed (0x0)
>   IRQ probe failed (0x0)
>   IRQ probe failed (0x0)
>   IRQ probe failed (0x0)
> 
> And then of course it fails to mount root.  No such problem using a
> kernel built from commit 97be852f of December 2nd.

Same here, btw - except that I couldn't catch the exact message as
nicely.

