Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbUEVRLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUEVRLp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 13:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbUEVRLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 13:11:45 -0400
Received: from canuck.infradead.org ([205.233.217.7]:10762 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261682AbUEVRLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 13:11:43 -0400
Date: Sat, 22 May 2004 13:11:40 -0400
From: hch@infradead.org
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, akpm@osdl.org
Subject: Re: PATCH: Stop megaraid trashing other i960 based devices
Message-ID: <20040522171140.GA9714@infradead.org>
Mail-Followup-To: hch@infradead.org, Matt Domsch <Matt_Domsch@dell.com>,
	Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, akpm@osdl.org
References: <20040522154659.GA17320@devserv.devel.redhat.com> <20040522160205.GA8643@infradead.org> <20040522160328.GA22256@devserv.devel.redhat.com> <20040522160718.GA8736@infradead.org> <20040522170706.GA27386@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040522170706.GA27386@lists.us.dell.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2004 at 12:07:06PM -0500, Matt Domsch wrote:
> Now, I love a good megaraid bashing as much as the next guy.  Just ask
> Peter Jarrett and Atul Mukker.  But in this case I have to side with
> them.  The cards w/o subsystem IDs all predate the existance of
> subsystem IDs in the PCI spec, and I'm pretty sure the IDs in the i960
> of that vintage are hard-coded so AMI couldn't have changed them if
> they wanted to.  So their magic words were the equivalent of what we
> now do with subsystem IDs.  It's only the older cards that have a
> problem, AFAIK.

Okay, so let's shoot an i960 engineer instead.  Intel bashing is even
more fun anyway ;-)

