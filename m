Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265170AbUDUHKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265170AbUDUHKM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 03:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265172AbUDUHKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 03:10:12 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:62593 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265170AbUDUHKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 03:10:08 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] psmouse fixes for 2.6.5
Date: Wed, 21 Apr 2004 02:10:06 -0500
User-Agent: KMail/1.6.1
References: <200404201038.46644.kim@holviala.com> <200404202117.37104.dtor_core@ameritech.net> <200404210948.29095.kim@holviala.com>
In-Reply-To: <200404210948.29095.kim@holviala.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404210210.06187.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Taking it off list for now...

On Wednesday 21 April 2004 01:48 am, Kim Holviala wrote:
> On Wednesday 21 April 2004 05:17, Dmitry Torokhov wrote:
> 
> > > > > - support for Targus Scroller mice (from my last weeks patch)
> > > >
> > > > Why do you have Tragus as a config option - just set the protocol mask
> > > > correctly by default...
> 
> It's not a config option, I just have a little note on the Kconfig file for 
> those that read the help pages.

You right, sorry... I just glanced over it in the morning, saw Kconfig being
changed and jumped to a conclusion. The only excuse: -ENOCOFFEE :)

I would recommend splitting your patch in 3 pieces - one for reset, one for
targus and one for protocol selection. This way its easuier for Vojtech to
apply them.

Question - why did you kill the protocol names array?

Btw, I am also trying to work in that area, might be beneficial if we combine
our efforts. I just posted bunch of changes on the list, you may also grab
them with

bk pull bk://dtor.bkbits.net/input

-- 
Dmitry
