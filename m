Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261808AbULUROg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbULUROg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 12:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbULUROg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 12:14:36 -0500
Received: from mail.kroah.org ([69.55.234.183]:58003 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261808AbULUROe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 12:14:34 -0500
Date: Tue, 21 Dec 2004 09:13:18 -0800
From: Greg KH <greg@kroah.com>
To: Arne Caspari <arnem@informatik.uni-bremen.de>
Cc: Adrian Bunk <bunk@stusta.de>, bcollins@debian.org,
       linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: updated: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
Message-ID: <20041221171317.GC1459@kroah.com>
References: <20041220015320.GO21288@stusta.de> <41C694E0.8010609@informatik.uni-bremen.de> <20041220175156.GW21288@stusta.de> <20041221004237.GJ21288@stusta.de> <41C7E2D7.7040806@informatik.uni-bremen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C7E2D7.7040806@informatik.uni-bremen.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2004 at 09:46:15AM +0100, Arne Caspari wrote:
> Adrian Bunk wrote:
> >On Mon, Dec 20, 2004 at 06:51:56PM +0100, Adrian Bunk wrote:
> >
> >>...
> >>After grepping through your CVS sources, it seems hpsb_read and 
> >>hpsb_write are the EXPORT_SYMBOLS affecting you?
> >>So keeping them should address your concerns?
> >>...
> 
> Adrian,
> 
> A stable API for the 2.6.x tree would address my concerns :-)

Please read Documentation/stable_api_nonesense.txt for details about why
that will never happen :)

thanks,

greg k-h
