Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263941AbTICQMk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 12:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263963AbTICQMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 12:12:40 -0400
Received: from mail.kroah.org ([65.200.24.183]:62338 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263941AbTICQMa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 12:12:30 -0400
Date: Wed, 3 Sep 2003 09:04:20 -0700
From: Greg KH <greg@kroah.com>
To: Tomas Konir <moje@vabo.cz>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@vger.kernel.org
Subject: Re: 2.4.22 + XFS oops with palm usb sync
Message-ID: <20030903160420.GB2634@kroah.com>
References: <Pine.LNX.4.53.0309022000260.7734@moje.vabo.cz> <20030903002743.GA21349@kroah.com> <Pine.LNX.4.53.0309030826060.26355@moje.vabo.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0309030826060.26355@moje.vabo.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 08:28:59AM +0200, Tomas Konir wrote:
> On Tue, 2 Sep 2003, Greg KH wrote:
> 
> > On Tue, Sep 02, 2003 at 08:07:09PM +0200, Tomas Konir wrote:
> > > 
> > > Hi
> > > 2.4.22 periodically oops after synchronization my palm (Tungsten T).
> > > Only XFS patches in kernel and no other. On usb was palm and Microsoft 
> > > mouse. (sometimes with previous kernels the mouse was disconnected after 
> > > synchronization). 
> > 
> > Known bug, sorry.  Use 2.6 instead.
> > 
> > Search the archives for details on what needs to be backported to 2.4 if
> > you really want to fix this problem.
> > 
> > Good luck,
> 
> 2.6.0-test4 sometimes hang up complete USB and all processes trying 
> to work with modules stay in D state. This is not very usable.
> (no messages in log).

Do you have ACPI enabled?  If so, see the many emails on this list about
that problem.

If not, please let us know.  Where are the USB modules hung at?

thanks,

greg k-h
