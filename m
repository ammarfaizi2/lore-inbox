Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264582AbUEOPuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264582AbUEOPuZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 11:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264638AbUEOPuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 11:50:25 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:24213 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S264582AbUEOPuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 11:50:20 -0400
Subject: Re: PATCH: (as279) Don't delete interfaces until all are unbound
From: Nuno Ferreira <nuno.ferreira@graycell.biz>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>, Duncan Sands <baldrick@free.fr>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sf.net
In-Reply-To: <Pine.LNX.4.44L0.0405131352500.651-100000@ida.rowland.org>
References: <Pine.LNX.4.44L0.0405131352500.651-100000@ida.rowland.org>
Content-Type: text/plain
Organization: Graycell
Message-Id: <1084636220.2901.1.camel@taz.graycell.biz>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.7 
Date: Sat, 15 May 2004 16:50:21 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Qui, 2004-05-13 at 13:56 -0400, Alan Stern wrote:
> On Thu, 13 May 2004, Duncan Sands wrote:
> 
> > No, but the pointer for another (previous) interface may just have been
> > set to NULL, causing an Oops when usb_ifnum_to_if loops over all
> > interfaces.
> 
> Of course!  I trust you won't mind me changing your suggested fix
> slightly.  This should do an equally good job of repairing things, and it
> will prevent other possible invalid references as well.

OK, I've now tested the patch ant it appears to work, I removed the USB
modem several times and not a single Oops to report.

Great work, thanks

