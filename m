Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262829AbUC2MF0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 07:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262831AbUC2MF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 07:05:26 -0500
Received: from localhost.nl ([62.250.6.43]:26373 "HELO maiden.localhost.nl")
	by vger.kernel.org with SMTP id S262829AbUC2MFU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 07:05:20 -0500
Date: Mon, 29 Mar 2004 14:05:19 +0200
From: Marco Baan <marco@freebsd.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: failure to mount root fs
Message-ID: <20040329120519.GA23337@maiden.localhost.nl>
References: <26889266.1080559781017.JavaMail.www@wwinf3002> <1080561608.3570.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1080561608.3570.2.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hi Macro,
> > 
> > You wrote:
> > 
> > > VFS: Unable to mount root fs on unknown-block(0,0)
> > > ...
> > > kernel /boot/bzImage-2.6.4 ro root=LABEL=/
> > 
> > The "LABEL=/" is the attempt to mount root filesystem by label, so you can 
> > move it to another disk. I find these "clever" things not mature yet and always replace it by an explicit device name (and don't move/replace root disk):
> 
> it's ok as long as you remember to make an initrd (make install in the
> kernel source will do so automatic, at least on a RH/Fedora system)

I didnt try a make install, but i manually added the initrd section.

The same error popped up though:

VFS: Unable to mount root fs on unknown-block(0,0)

-- 
Marco Baan

There is no time like the present for postponing what you ought to be
doing.
