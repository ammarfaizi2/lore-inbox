Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbVHKUen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbVHKUen (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 16:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbVHKUen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 16:34:43 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:36540 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932423AbVHKUel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 16:34:41 -0400
Date: Thu, 11 Aug 2005 21:34:37 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] IDE: don't offer IDE_GENERIC on ia64
Message-ID: <20050811203437.GA9265@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Bjorn Helgaas <bjorn.helgaas@hp.com>,
	B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-ia64@vger.kernel.org
References: <200508111424.43150.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508111424.43150.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2005 at 02:24:43PM -0600, Bjorn Helgaas wrote:
> IA64 boxes only have PCI IDE devices, so there's no need to blindly poke
> around in I/O port space.  Poking at things that don't exist causes MCAs
> on HP ia64 systems.

Maybe it should instead depend on those systems where it is available.
Anything but X86?

