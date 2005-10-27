Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932670AbVJ0WOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932670AbVJ0WOH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 18:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932671AbVJ0WOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 18:14:07 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:1988
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S932670AbVJ0WOG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 18:14:06 -0400
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: Dave Jones <davej@redhat.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Subject: Re: 4GB memory and Intel Dual-Core system
Date: Thu, 27 Oct 2005 18:13:57 -0400
Message-Id: <20051027221158.M52510@linuxwireless.org>
In-Reply-To: <20051027220533.GA18773@redhat.com>
References: <1130445194.5416.3.camel@blade> <52mzkuwuzg.fsf@cisco.com> <20051027204923.M89071@linuxwireless.org> <1130446667.5416.14.camel@blade> <20051027205921.M81949@linuxwireless.org> <1130447261.5416.20.camel@blade> <20051027211203.M33358@linuxwireless.org> <20051027220533.GA18773@redhat.com>
X-Mailer: Open WebMail 2.40 20040816
X-OriginatingIP: 16.126.157.6 (abonilla@linuxwireless.org)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Oct 2005 18:05:33 -0400, Dave Jones wrote
> On Thu, Oct 27, 2005 at 05:15:50PM -0400, Alejandro Bonilla wrote:
>  > On Thu, 27 Oct 2005 23:07:41 +0200, Marcel Holtmann wrote
>  > > Hi Alejandro,
>  > > 
>  > > > > the board in this system is a Intel D945GNT and the box 
> tells me the > > > > maximum supported amount of RAM is 4 GB. So 
> there should be a way to > > > > address this amount memory. > > > 
>  > > > The board did take the 4GB of RAM and it is finding them, 
> therefore supports > > > them. It is just not designed to give a 
> full 4GB of RAM to the system, it only > > > gives 3.4XGB RAM and 
> the rest is really not used, then basically the system > > > just 
> tries to give the 0.6xGB RAM remaining a task by it being used by "System
>  > > > Resources"
>  > > > 
>  > > > This isn't really Linux dependant.
>  > > 
>  > > so there is no way to give me back the "lost" memory. Is it possible
>  > > that another motherboard might help?
>  > 
>  > AFAIK, No. AMD and Intel will always do the same thing until we 
> all move to > real IA64.
> 
> Somehow, I doubt AMD see it that way :-)
> 
> Some boards at least have a BIOS option to support 'memory hoisting'
> to map the 'lost' memory above the 4G address space.

True, probably AMD added a "workaround" for this problem, but by nature, this
is what happens.
> 
> I suspect a lot of the lower-end (and older) boards however don't 
> have this option, as they were not tested with 4GB.

Probably no Intel boards have the option. So, it would be that Marcel contact
Intel so they can add a mapping option on the BIOS for this situation. It is
somehow missleading.

.Alejandro

> 
> 		Dave


