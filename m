Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264929AbTLWAto (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 19:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264930AbTLWAto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 19:49:44 -0500
Received: from mail.kroah.org ([65.200.24.183]:9650 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264929AbTLWAtm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 19:49:42 -0500
Date: Mon, 22 Dec 2003 16:49:38 -0800
From: Greg KH <greg@kroah.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Badness in pci_find_subsys & sleeping function called from invalid context
Message-ID: <20031223004937.GA5341@kroah.com>
References: <Pine.LNX.4.56.0312221959460.27724@jju_lnx.backbone.dif.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0312221959460.27724@jju_lnx.backbone.dif.dk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 08:10:44PM +0100, Jesper Juhl wrote:
> 
> After upgrading to 2.6.0 (from 2.4.22)I'm getting a lot of the below
> messages in my logs.
> I'm well aware that this might purely be a problem with the binary Nvidia
> drivers I'm using with my Geforce3, especially since I had to use the patches
> available from http://www.minion.de/ to be able to use those drivers at all,

That's exactly what is causing this problem.  Sorry, nothing we can do
about it here.

greg k-h
