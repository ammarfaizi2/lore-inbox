Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265084AbTFUHbg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 03:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265086AbTFUHbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 03:31:36 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:64773 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S265084AbTFUHbg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 03:31:36 -0400
Date: Sat, 21 Jun 2003 09:45:35 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Lou Langholtz <ldl@aros.net>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>, Steven Whitehouse <steve@chygwyn.com>
Subject: Re: [RFC][PATCH] nbd driver for 2.5.72
Message-ID: <20030621074535.GA2131@mars.ravnborg.org>
Mail-Followup-To: viro@parcelfarce.linux.theplanet.co.uk,
	Lou Langholtz <ldl@aros.net>, linux-kernel@vger.kernel.org,
	Pavel Machek <pavel@ucw.cz>, Steven Whitehouse <steve@chygwyn.com>
References: <3EF3F08B.5060305@aros.net> <20030621073224.GJ6754@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030621073224.GJ6754@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 21, 2003 at 08:32:24AM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> > +static int nbd_debug_write_proc(struct file *file, const char *buffer,
> > +		unsigned long count, void *data)
> > +{
> 
> 	First of all, "buffer" is userland pointer.

Annotate user pointers with __user.

	Sam
