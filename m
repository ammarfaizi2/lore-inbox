Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270809AbTGVMfx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 08:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270810AbTGVMfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 08:35:53 -0400
Received: from mail.kroah.org ([65.200.24.183]:22427 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270809AbTGVMfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 08:35:52 -0400
Date: Tue, 22 Jul 2003 08:50:39 -0400
From: Greg KH <greg@kroah.com>
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Non-ASCII chars in visor.c messages
Message-ID: <20030722125039.GA2310@kroah.com>
References: <20030722143821.C26218@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030722143821.C26218@fi.muni.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 02:38:21PM +0200, Jan Kasprzak wrote:
> 	Hello,
> 
> what is the general opinion on printing non-ASCII characters in kernel
> messages? I think kernel should print either pure ASCII messages, or
> at least UTF-8-encoded ones.

"pure ASCII"?  Heh, that's the first time I've heard that.

> 	The visor.c module contains three messages
> with non-ASCII character ("e" with acute above, encoded in
> ISO 8859-1, in the name of "Sony Clie'" handheld). I propose the attached
> patch, which works in all environments (altough UTF-8 variant would be
> IMHO fine as well).
> 
> 	What do you think about it?

I don't think it's really needed.  Why change this, syslog can't handle
this?  It works for me...

thanks,

greg k-h
