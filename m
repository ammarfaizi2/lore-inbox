Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262350AbUKDSR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262350AbUKDSR0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 13:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbUKDSJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 13:09:08 -0500
Received: from mikonos.cyclades.com.br ([200.230.227.67]:32521 "EHLO
	cyclades.com.br") by vger.kernel.org with ESMTP id S262309AbUKDSAV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 13:00:21 -0500
Subject: RE: patch for sysfs in the cyclades driver
From: Germano <germano.barreiro@cyclades.com>
Reply-To: germano.barreiro@cyclades.com
To: "Kilau, Scott" <Scott_Kilau@digi.com>
Cc: Greg KH <greg@kroah.com>, Roland Dreier <roland@topspin.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <71A17D6448EC0140B44BCEB8CD0DA36E041BF5BC@minimail.digi.com>
References: <71A17D6448EC0140B44BCEB8CD0DA36E041BF5BC@minimail.digi.com>
Content-Type: text/plain; charset=iso-8859-1
Organization: Cyclades Latin America
Message-Id: <1099592893.2161.6.camel@tsthost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 04 Nov 2004 16:28:13 -0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I send my thanks to all too. Finally (I hope no new problems appear) the
exit of the maze :)


Em Qui, 2004-11-04 às 15:50, Kilau, Scott escreveu:
> > > and the implementation in in drivers/scsi/st.c, that there's no
> > > problem adding attributes to a device in a simple class.  You can
> just
> > > use class_set_devdata() on your class_device to set whatever context
> > > you need to get back to your internal structures, and then use
> > > class_device_create_file() to add the attributes.
> > > 
> > > I assume this is OK (since there is already one in-kernel driver
> doing
> > > it), but Greg, can you confirm that it's definitely OK for a driver
> to
> > > use class_set_devdata() on a class_device from
> class_simple_device_add()?
> 
> > Hm, I think that should be ok, but I'd make sure to test it before
> > verifying that it really is :)
> 
> I have just added this code and tested it, and indeed it *does* work!
> 
> So I will graciously redraw my comments from my previous email.
> It works, and this is definitely the way Germano and I should go in
> each of our respective drivers.
> 
> Thanks again for everyones comments/help!
> 
> Scott Kilau
> Digi International
> 

