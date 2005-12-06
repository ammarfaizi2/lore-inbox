Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932610AbVLFWZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932610AbVLFWZh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 17:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbVLFWZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 17:25:37 -0500
Received: from baythorne.infradead.org ([81.187.2.161]:2981 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S932610AbVLFWZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 17:25:36 -0500
Subject: Re: Linux in a binary world... a doomsday scenario
From: David Woodhouse <dwmw2@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Brian Gerst <bgerst@didntduck.org>, Andrea Arcangeli <andrea@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1133897035.23610.32.camel@localhost.localdomain>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
	 <20051205121851.GC2838@holomorphy.com>
	 <20051206011844.GO28539@opteron.random> <43944F42.2070207@didntduck.org>
	 <20051206030828.GA823@opteron.random>  <4394696B.6060008@didntduck.org>
	 <1133894575.4136.171.camel@baythorne.infradead.org>
	 <1133897035.23610.32.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 06 Dec 2005 22:25:22 +0000
Message-Id: <1133907922.4136.218.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-06 at 19:23 +0000, Alan Cox wrote:
> On Maw, 2005-12-06 at 18:42 +0000, David Woodhouse wrote:
> > There's some work on reverse-engineering the BIOS so that you can
> > hackishly poke 'new' modes into its tables, but it's still not a very
> > good option.
> 
> Especially as the BIOS interface at the low level for the analogue end
> and the logic driving it is board specific. Intel have been fairly clear
> why they use the BIOS interface.

Have they? I haven't seen the excuse.

I assume it's similar to the excuse for ACPI -- "although we _could_
document the chips and allow board manufacturers to include simple
tables which describe the way they're wired together (in which they have
relatively little leeway), we'd rather hide it all behind some opaque
blob and have you trust HardwareVendorCode to drive it instead of being
able to write your own and debug it as you can with Free Software"?

Trusting the BIOS for this kind of thing isn't really much better than
trusting any other binary-only piece of code, from a technical point of
view. (Ignoring the licensing issues; we have indeed digressed). In
fact, given the traditional quality of BIOS implementations, trusting
the BIOS is far _worse_ than trusting any other piece of binary code.

-- 
dwmw2


