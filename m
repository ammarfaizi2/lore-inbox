Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265167AbUENKYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265167AbUENKYp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 06:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265172AbUENKYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 06:24:45 -0400
Received: from marte.lusodigital.net ([216.234.186.41]:33805 "EHLO
	www.marte.lusodigital.net") by vger.kernel.org with ESMTP
	id S265167AbUENKYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 06:24:44 -0400
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
Message-Id: <1084530276.4062.1.camel@taz.graycell.biz>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.7 
Date: Fri, 14 May 2004 11:24:36 +0100
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

I've been out of town so I could not test this patch yet. I'll try it
later tonight and let you know if it's fixed.

Thanks
-- 
Nuno Ferreira

