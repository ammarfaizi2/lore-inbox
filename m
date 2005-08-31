Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964999AbVIAAZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbVIAAZe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 20:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbVIAAZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 20:25:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:19611 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964999AbVIAAZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 20:25:33 -0400
Date: Wed, 31 Aug 2005 13:56:04 -0700
From: Greg KH <greg@kroah.com>
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>,
       video4linux-list@redhat.com
Subject: Re: [PATCH 2.6] I2C: Drop I2C_DEVNAME and i2c_clientname
Message-ID: <20050831205604.GJ19361@kroah.com>
References: <20050815195704.7b61206e.khali@linux-fr.org> <1124741348.4516.51.camel@localhost> <20050825001958.63b2525c.khali@linux-fr.org> <1125360762.6186.29.camel@localhost> <20050830232008.3420f0f1.khali@linux-fr.org> <1125502498.9401.99.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125502498.9401.99.camel@localhost>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 at 12:34:58PM -0300, Mauro Carvalho Chehab wrote:
> Em Ter, 2005-08-30 ?s 23:20 +0200, Jean Delvare escreveu:
> > Hi Mauro,
> > 
> > > (...) it would be nice not to have a different I2C
> > > API for every single 2.6 version :-) It would be nice to change I2C
> > > API once and keep it stable for a while.
> 
> > The Linux 2.6 development model is designed around a relatively fast
> > move from -mm to Linus' tree, which implies incremental changes all the
> > time. I'm only doing that.
> 	It is ok to change code, but, IMHO, API should be more stable.

I take it you have not read Documentation/stable_api_nonsense.txt yet?
If not, please do, it shows that what you are asking for will not
happen.

good luck,

greg k-h
