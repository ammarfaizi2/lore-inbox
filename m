Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266755AbUGLIXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266755AbUGLIXQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 04:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266756AbUGLIXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 04:23:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4504 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266755AbUGLIXO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 04:23:14 -0400
Date: Mon, 12 Jul 2004 09:23:13 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: watchdog infrastructure
Message-ID: <20040712082313.GW12308@parcelfarce.linux.theplanet.co.uk>
References: <200407011923.45226.arnd@arndb.de> <20040705093800.GB5726@infomag.infomag.iguana.be> <200407051454.48340.arnd@arndb.de> <20040712081939.GJ5726@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040712081939.GJ5726@infomag.infomag.iguana.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2004 at 10:19:39AM +0200, Wim Van Sebroeck wrote:
> > - You need to get the module reference count before calling any
> >   watchdog operation, the best place for this is probably the
> >   open() fop.

Huh?  Just set ->owner in file_operations and be done with that.
