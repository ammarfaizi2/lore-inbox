Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265297AbTFMJXS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 05:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265298AbTFMJXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 05:23:18 -0400
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:13318 "EHLO
	krusty.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S265297AbTFMJXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 05:23:12 -0400
Date: Fri, 13 Jun 2003 11:36:56 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: AIC7xxx 6.2.8: "no active SCB for reconnecting target"
Message-ID: <20030613093655.GA4774@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <20030613084232.GA3422@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030613084232.GA3422@merlin.emma.line.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jun 2003, Matthias Andree wrote:

> I have some new issues on machine with AIC7880 that has been stable for
> almost 5 years, and also after the last updates half a year ago. These
> troubles have started recently when I removed a Permedia2 video card
> (PCI), but the card has been put back, yet the troubles persist (I don't
> think it's related, but I mention it anyways), so I think this is a
> coincidence.

It wasn't. Somebody else looked at the hardware, he found that the
cabling was triggering these faults (it had _not_ been removed from the
drives or host adaptor) and reproduced the issue and then fixed the
cable. So consider this closed.
