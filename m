Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264450AbTKMW1H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 17:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264451AbTKMW1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 17:27:07 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:35046 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S264450AbTKMW1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 17:27:05 -0500
Date: Thu, 13 Nov 2003 16:26:16 -0600
From: Erik Jacobson <erikj@efs.americas.sgi.com>
To: Jonathan Corbet <corbet@lwn.net>
cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seq_file version of /proc/interrupts 
In-Reply-To: <20031113213927.27114.qmail@lwn.net>
Message-ID: <Pine.SGI.4.53.0311131624150.183845@efs.americas.sgi.com>
References: <20031113213927.27114.qmail@lwn.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here, anyway, is a better version of the patch.  It's less intrusive,
> forgoes some "cleanups" I indulged in the first time, and makes it easier
> to update other architectures.  I did x86-64, ia_64 and ppc64 just for the
> heck of it, but I can't test them.

I tested your changes on a small ia64 Altix here.  It worked well.  I'll try
it out on a 512p system when I can get a time slot on it.

Thanks for doing this.

Erik
