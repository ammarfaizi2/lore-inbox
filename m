Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267179AbTBDItn>; Tue, 4 Feb 2003 03:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267183AbTBDItn>; Tue, 4 Feb 2003 03:49:43 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:51982 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267179AbTBDItm>; Tue, 4 Feb 2003 03:49:42 -0500
Date: Tue, 4 Feb 2003 08:59:15 +0000
From: Christoph Hellwig <hch@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: make pci_direct_conf1 structure nonstatic
Message-ID: <20030204085915.A28816@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org
References: <20030204084526.GA361@pazke>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030204084526.GA361@pazke>; from pazke@orbita1.ru on Tue, Feb 04, 2003 at 11:45:26AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2003 at 11:45:26AM +0300, Andrey Panin wrote:
> Hi,
> 
> this triial patch is needed to use pci access functions from 
> i386/pci/direct.c by the visws pci code. To achieve this patch
> makes pci_direct_conf1 structure (which hold pci pointers of access 
> functions) nonstatic. PCI id for SGI lithium hostbridge is added also.
> 
> SGI visws supports pci type 1 pci access, but needs different 
> bus and irq enumeration logic.
> 
> Please consider applying.

Linus usually only applies patches that have him in the To (or maybe Cc)
line.  It might also worth to send all the small patches as a series
(i.e. [PATCH] bring visw back alive (1/10)) so he sees a grand goal)


