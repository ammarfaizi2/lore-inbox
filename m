Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270828AbTGVNDz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 09:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270829AbTGVNDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 09:03:55 -0400
Received: from mail.kroah.org ([65.200.24.183]:22687 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270828AbTGVNDy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 09:03:54 -0400
Date: Tue, 22 Jul 2003 09:18:32 -0400
From: Greg KH <greg@kroah.com>
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Non-ASCII chars in visor.c messages
Message-ID: <20030722131832.GB2389@kroah.com>
References: <20030722143821.C26218@fi.muni.cz> <20030722125039.GA2310@kroah.com> <20030722150941.E26218@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030722150941.E26218@fi.muni.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 03:09:42PM +0200, Jan Kasprzak wrote:
> Greg KH wrote:
> : > 
> : > 	What do you think about it?
> : 
> : I don't think it's really needed.  Why change this, syslog can't handle
> : this?  It works for me...
> : 
> 	Yes, syslog can handle this, but in order to parse syslog files
> you should have your LC_CTYPE set to something Latin-1 compatible
> (which UTF-8 is not, and it is the default on many distros).
> 
> 	Why Latin-1 and not UTF-8? I think UTF-8 is more "correct", while
> ASCII is "works for all". Latin-1 is neither "correct" nor "works for all".

So how do you encode that character in UTF-8?

If we are going to print device names, I want to be correct in their
usage...

thanks,

greg k-h
