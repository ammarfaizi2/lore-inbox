Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263338AbUFVMj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbUFVMj4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 08:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263169AbUFVMjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 08:39:55 -0400
Received: from [213.146.154.40] ([213.146.154.40]:64132 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263338AbUFVMjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 08:39:54 -0400
Date: Tue, 22 Jun 2004 13:39:48 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] iSeries virtual i/o sysfs files
Message-ID: <20040622123948.GA2089@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>, jgarzik@pobox.com,
	linux-kernel@vger.kernel.org
References: <20040622140405.4cb6f8e1.sfr@canb.auug.org.au> <40D7CFBC.30706@pobox.com> <20040622212319.2a0c121b.sfr@canb.auug.org.au> <20040622113103.GA1288@infradead.org> <20040622223449.160fa820.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040622223449.160fa820.sfr@canb.auug.org.au>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2004 at 10:34:49PM +1000, Stephen Rothwell wrote:
> On Tue, 22 Jun 2004 12:31:03 +0100 Christoph Hellwig <hch@infradead.org> wrote:
> >
> > Maybe you should just kick your collegues on the OS/400 side to provide
> > a better interface?  After IBM is oh so Linux friendly they could maybe
> > fi up their legacy codebases to make the slightest bit of sense?
> 
> Thank you for your constructive comment ...

This might sound harsh, but it's exactly what I mean.  What the heck is
the problem with adding HvCall_EnumerateDeviceInStudlyCaps from the hypevisor?

I can't see why we should mess up all the kernel just because the vendor
can't fix up another piece of software.

