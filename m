Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbVHKUh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbVHKUh6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 16:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbVHKUh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 16:37:57 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:57265 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S932432AbVHKUh4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 16:37:56 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] IDE: don't offer IDE_GENERIC on ia64
Date: Thu, 11 Aug 2005 14:37:46 -0600
User-Agent: KMail/1.8.1
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, linux-ia64@vger.kernel.org
References: <200508111424.43150.bjorn.helgaas@hp.com> <20050811203437.GA9265@infradead.org>
In-Reply-To: <20050811203437.GA9265@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508111437.46958.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 August 2005 2:34 pm, Christoph Hellwig wrote:
> On Thu, Aug 11, 2005 at 02:24:43PM -0600, Bjorn Helgaas wrote:
> > IA64 boxes only have PCI IDE devices, so there's no need to blindly poke
> > around in I/O port space.  Poking at things that don't exist causes MCAs
> > on HP ia64 systems.
> 
> Maybe it should instead depend on those systems where it is available.
> Anything but X86?

I'm OK with that, but don't want to be responsible for coming up
with the list of systems where it should be available :-)
