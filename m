Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262771AbVBBXOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbVBBXOz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 18:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262833AbVBBXOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 18:14:55 -0500
Received: from mail.kroah.org ([69.55.234.183]:10434 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262771AbVBBXH3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 18:07:29 -0500
Date: Wed, 2 Feb 2005 15:07:18 -0800
From: Greg KH <greg@kroah.com>
To: Pavel Roskin <proski@gnu.org>
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: Please open sysfs symbols to proprietary modules
Message-ID: <20050202230718.GA14055@kroah.com>
References: <Pine.LNX.4.62.0502021723280.5515@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0502021723280.5515@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 05:56:57PM -0500, Pavel Roskin wrote:
> I'm writing a module under a proprietary license.  I decided to use sysfs 
> to do the configuration.  Unfortunately, all sysfs exports are available 
> to GPL modules only because they are exported by EXPORT_SYMBOL_GPL.

Heh, a gnu.org email address asking for us to change the GPL marking on
symbols.  Ah, the irony...

> Please replace every EXPORT_SYMBOL_GPL with EXPORT_SYMBOL in fs/sysfs/*.c

Sorry, but the answer is no.

Good luck,

greg k-h
