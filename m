Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbVKVDnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbVKVDnx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 22:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbVKVDnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 22:43:53 -0500
Received: from smtp111.sbc.mail.re2.yahoo.com ([68.142.229.94]:15476 "HELO
	smtp111.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750960AbVKVDnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 22:43:52 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Marc Koschewski <marc@osknowledge.org>
Subject: Re: 2.6.15-rc1-mm2 unsusable on DELL Inspiron 8200, 2.6.15-rc1 works fine
Date: Mon, 21 Nov 2005 22:43:50 -0500
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <20051118182910.GJ6640@stiffy.osknowledge.org> <200511182207.19984.dtor_core@ameritech.net> <20051120171409.GA7285@stiffy.osknowledge.org>
In-Reply-To: <20051120171409.GA7285@stiffy.osknowledge.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511212243.50707.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 November 2005 12:14, Marc Koschewski wrote:
> * Dmitry Torokhov <dtor_core@ameritech.net> [2005-11-18 22:07:19 -0500]:
> 
> > On Friday 18 November 2005 13:29, Marc Koschewski wrote:
> > > Nov 18 12:58:37 stiffy kernel: psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, throwing 1 bytes away.
> > > 
> > > SOME STUFF MISSING? HUH?
> > > 
> > > Nov 18 13:03:14 stiffy kernel: psmouse.c: resync failed, issuing reconnect request
> > > 
> > 
> > Hm, this worries me a bit... Could you please try appying the patch
> > below to plain 2.6.15-rc1 and see if mouse starts misbehaving again?
> 
> Dmitry,
> 
> I applied the 5 patches to a plain 2.6.15-rc1. The mouse was well as if it was
> in an unpatched kernel. The problem just occured in 2.6.15-rc1-mmX.
> Plain 2.6.15-rc1 was fine before as well. So: actually no change.
> 
> Need any more info?
>

Marc,

Thank you for testing the patch. It proves that your mouse troubles
were not caused by the patch I made so I am very happy. "No change"
is the result I wanted to hear ;)

-- 
Dmitry
