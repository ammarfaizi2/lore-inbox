Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbUFVLbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbUFVLbO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 07:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbUFVLbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 07:31:13 -0400
Received: from [213.146.154.40] ([213.146.154.40]:2948 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262453AbUFVLbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 07:31:11 -0400
Date: Tue, 22 Jun 2004 12:31:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] iSeries virtual i/o sysfs files
Message-ID: <20040622113103.GA1288@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
References: <20040622140405.4cb6f8e1.sfr@canb.auug.org.au> <40D7CFBC.30706@pobox.com> <20040622212319.2a0c121b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040622212319.2a0c121b.sfr@canb.auug.org.au>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2004 at 09:23:19PM +1000, Stephen Rothwell wrote:
> What it means is that, as the patch stands, a node is created in
> /sys/devices/vio (and /sys/bus/vio/devices) for all possible virtual
> devices not just those actually present.  The exception is for virtual
> ethernets which are relatively easy to enumerate.  To enumerate the other
> devices precisely, I will need to extract the device probing code from
> each of the other device drivers (viodasd, viocd and viotape) and include
> some (hopefully simplified) form of the code directly into the bus probing
> code for iSeries in vio.c.

Maybe you should just kick your collegues on the OS/400 side to provide
a better interface?  After IBM is oh so Linux friendly they could maybe
fi up their legacy codebases to make the slightest bit of sense?
