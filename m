Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbVBNSPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVBNSPn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 13:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVBNSPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 13:15:43 -0500
Received: from mail.kroah.org ([69.55.234.183]:7114 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261508AbVBNSPj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 13:15:39 -0500
Date: Mon, 14 Feb 2005 09:41:11 -0800
From: Greg KH <greg@kroah.com>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Gerrit Huizenga <gh@us.ibm.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Jay Lan <jlan@engr.sgi.com>
Subject: Re: [RFC][PATCH 2.6.11-rc3-mm2] Relay Fork Module
Message-ID: <20050214174111.GB6697@kroah.com>
References: <1107786245.9582.27.camel@frecb000711.frec.bull.fr> <20050207154623.33333cda.akpm@osdl.org> <1108109504.30559.43.camel@frecb000711.frec.bull.fr> <20050211005446.081aa075.akpm@osdl.org> <1108134520.14068.66.camel@frecb000711.frec.bull.fr> <20050211191112.GB19139@kroah.com> <1108369609.25606.29.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108369609.25606.29.camel@frecb000711.frec.bull.fr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2005 at 09:26:49AM +0100, Guillaume Thouvenin wrote:
> 
>  I'm using kobject because it allows to notify user space application by
> sending an event and as I need to send a kernel event (fork event) to a
> user space application I thought about kobject. Do you think that it's
> not the good solution because it's a too big mechanism for what I want
> to do?

Yes, I think it is too "big" of a solution, take a look at the connector
code, it is what you want to use instead.

thanks,

greg k-h
