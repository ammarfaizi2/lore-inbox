Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262169AbUKWGqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbUKWGqd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 01:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262230AbUKWGq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 01:46:29 -0500
Received: from mail.kroah.org ([69.55.234.183]:30653 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262169AbUKWGps (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 01:45:48 -0500
Date: Mon, 22 Nov 2004 22:45:08 -0800
From: Greg KH <greg@kroah.com>
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][RFC/v1][11/12] Add InfiniBand Documentation files
Message-ID: <20041123064508.GC22493@kroah.com>
References: <20041122714.taTI3zcdWo5JfuMd@topspin.com> <20041122714.AyIOvRY195EGFTaO@topspin.com> <20041122225335.GE15634@kroah.com> <52sm71bie2.fsf@topspin.com> <20041122230533.GB13083@kroah.com> <20041122233047.GH27658@sventech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122233047.GH27658@sventech.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 03:30:47PM -0800, Johannes Erdfelt wrote:
> On Mon, Nov 22, 2004, Greg KH <greg@kroah.com> wrote:
> > On Mon, Nov 22, 2004 at 02:58:45PM -0800, Roland Dreier wrote:
> > >     Greg> Oh, have you asked for a real major number to be reserved
> > >     Greg> for umad?
> > > 
> > > No, I think we're fine with a dynamic major.  Is there any reason to
> > > want a real major?
> > 
> > People who do not use udev will not like you.
> 
> I don't quite understand this. Given things like udev, wouldn't dynamic
> majors work just like having a static major number?

Yes, but people who do not use udev, will have a hard time creating the
device nodes by hand every time.

thanks,

greg k-h
