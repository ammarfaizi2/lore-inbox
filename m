Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbUK1NDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbUK1NDY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 08:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbUK1NDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 08:03:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35468 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261459AbUK1NDV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 08:03:21 -0500
Date: Sun, 28 Nov 2004 13:03:19 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: ecki-news2004-05@lina.inka.de, linux-kernel@vger.kernel.org
Subject: Re: Problem with ioctl command TCGETS
Message-ID: <20041128130319.GB26051@parcelfarce.linux.theplanet.co.uk>
References: <E1CYMI9-0005PL-00@calista.eckenfels.6bone.ka-ip.net> <E1CYN7z-0001bZ-00@dorka.pomaz.szeredi.hu> <20041128121800.GZ26051@parcelfarce.linux.theplanet.co.uk> <E1CYODw-0001jf-00@dorka.pomaz.szeredi.hu> <20041128124847.GA26051@parcelfarce.linux.theplanet.co.uk> <E1CYOXh-0001nn-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CYOXh-0001nn-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2004 at 01:52:41PM +0100, Miklos Szeredi wrote:
> 
> > > > Think read(2)/write(2).  We already have several barfbags too many,
> > > > and that includes both ioctl() and setsockopt().  We are stuck with
> > > > them for compatibility reasons, but why the hell would we need yet
> > > > another one?
> > > 
> > > You can't replace either ioctl() or setsockopt() with read/write can
> > > you?  Both of them set out-of-band information on file descriptors.
> > 
> > Out-of-band == should be on a separate channel...
> 
> Tell me how?  E.g. how would you set/get sound stream parameters if
> not with ioctl()?

Have several related files.
