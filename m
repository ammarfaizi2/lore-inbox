Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbTJMTcH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 15:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbTJMTcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 15:32:07 -0400
Received: from mail.kroah.org ([65.200.24.183]:44990 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261891AbTJMTcF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 15:32:05 -0400
Date: Mon, 13 Oct 2003 12:31:14 -0700
From: Greg KH <greg@kroah.com>
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-kernel@vger.kernel.org, frodol@dds.nl,
       Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
Subject: Re: [patch] sensors/w83781d.c creates useless sysfs entries
Message-ID: <20031013193114.GA11582@kroah.com>
References: <3F8805A7.6080306@kmlinux.fjfi.cvut.cz> <20031011163244.GA2570@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031011163244.GA2570@dreamland.darkstar.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 11, 2003 at 06:32:44PM +0200, Kronos wrote:
> Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz> ha scritto:
> > Hello,
> > 
> > here is a trivial fix for Winbond sensor driver, which currently creates 
> > useless entries in sys/bus/i2c due to missing braces after if statements 
> > - author probably forgot about the macro expansion.
> 
> IMHO it's better to fix the macro:

Thanks, I've applied this version.

greg k-h
