Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVFNSQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVFNSQw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 14:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVFNSQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 14:16:52 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:4690 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261280AbVFNSQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 14:16:49 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Input sysbsystema and hotplug
Date: Tue, 14 Jun 2005 13:16:40 -0500
User-Agent: KMail/1.8.1
Cc: Greg KH <gregkh@suse.de>, linux-hotplug-devel@lists.sourceforge.net,
       Vojtech Pavlik <vojtech@suse.cz>, Kay Sievers <kay.sievers@vrfy.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <200506131607.51736.dtor_core@ameritech.net> <20050614063851.GA19620@suse.de> <9e473391050614080230ae359d@mail.gmail.com>
In-Reply-To: <9e473391050614080230ae359d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506141316.42266.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 June 2005 10:02, Jon Smirl wrote:
> On 6/14/05, Greg KH <gregkh@suse.de> wrote:
> > Heh, yes, sorry, you did.
> > 
> > Hm, I don't even remember why I didn't like it anymore, last I remember,
> > I think you got the parent reference counting correct, right?  Care to
> > dig out the patch and send it again?
> 
> I brought this forward from a kernel a couple of months old so it may
> need some checking.
>

Ah, this one allows adding subdevices to class devices whereas mine is for
adding subclasses to classes. Both are needed in the long run IMHO.
 
-- 
Dmitry
