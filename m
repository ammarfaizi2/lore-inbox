Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262843AbSJAXTB>; Tue, 1 Oct 2002 19:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262910AbSJAXSF>; Tue, 1 Oct 2002 19:18:05 -0400
Received: from dp.samba.org ([66.70.73.150]:46014 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262906AbSJAXRR>;
	Tue, 1 Oct 2002 19:17:17 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15770.11696.250776.892900@argo.ozlabs.ibm.com>
Date: Wed, 2 Oct 2002 09:20:16 +1000 (EST)
To: Greg KH <greg@kroah.com>
Cc: Martin Diehl <lists@mdiehl.de>, linux-kernel@vger.kernel.org
Subject: Re: calling context when writing to tty_driver
In-Reply-To: <20021001183400.GA8959@kroah.com>
References: <Pine.LNX.4.21.0210010523290.485-100000@notebook.diehl.home>
	<20021001183400.GA8959@kroah.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH writes:

> On Tue, Oct 01, 2002 at 12:37:42PM +0200, Martin Diehl wrote:
> > 
> > Hi,
> > 
> > just hitting another "sleeping on semaphore from illegal context" issue
> > with 2.5.39. Happened on down() in either usbserial->write_room() or
> > usbserial->write(), when invoked from bh context.
> 
> Can you send me the whole backtrace?  I'm curious as to who is calling
> those functions from bh context.

PPP will do that.

Paul.
