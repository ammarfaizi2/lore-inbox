Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbUCKBpb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 20:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262944AbUCKBok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 20:44:40 -0500
Received: from mail.kroah.org ([65.200.24.183]:28077 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262946AbUCKBn2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 20:43:28 -0500
Date: Wed, 10 Mar 2004 17:33:42 -0800
From: Greg KH <greg@kroah.com>
To: Paulo Marques <pmarques@grupopie.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Andy Lutomirski <luto@myrealbox.com>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] usblp.c (Was: usblp_write spins forever after an error)
Message-ID: <20040311013342.GH13045@kroah.com>
References: <402FEAD4.8020602@myrealbox.com> <20040216035834.GA4089@kroah.com> <4030DEC5.2060609@grupopie.com> <1078399532.4619.129.camel@hades.cambridge.redhat.com> <4047221E.9050500@grupopie.com> <1078479692.12176.32.camel@imladris.demon.co.uk> <40488E45.7070901@grupopie.com> <4048C2E7.8050907@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4048C2E7.8050907@grupopie.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2004 at 06:11:51PM +0000, Paulo Marques wrote:
> 
> Here it is.
> 
> The patch is only one line for 2.6.4-rc2. (I also did a little formatting 
> adjustment to better comply with CodingStyle)
> 
> For the 2.4.26-pre1 kernel, I also backported the return codes correction 
> patch from Oliver Neukum.

Thanks, I've applied this to both the 2.4 and 2.6 usb trees.

greg k-h
