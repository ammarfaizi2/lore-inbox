Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbUEVQHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbUEVQHV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 12:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUEVQHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 12:07:20 -0400
Received: from canuck.infradead.org ([205.233.217.7]:40457 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261498AbUEVQHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 12:07:19 -0400
Date: Sat, 22 May 2004 12:07:18 -0400
From: hch@infradead.org
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.rg, akpm@osdl.orgy
Subject: Re: PATCH: Stop megaraid trashing other i960 based devices
Message-ID: <20040522160718.GA8736@infradead.org>
Mail-Followup-To: hch@infradead.org, Alan Cox <alan@redhat.com>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.rg,
	akpm@osdl.orgy
References: <20040522154659.GA17320@devserv.devel.redhat.com> <20040522160205.GA8643@infradead.org> <20040522160328.GA22256@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040522160328.GA22256@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2004 at 12:03:28PM -0400, Alan Cox wrote:
> > I think we should add all valid subvendor ids to the pci_id table instead.
> > Especially to not consude the hotplug package.
> 
> Most of the megaraids don't have subvendor ids... so that doesn't work at
> all.

Okay.  In that case we should apply the patch and shoot some megraid
hardware engineer.

(and keep linux-scsi in the loop)
