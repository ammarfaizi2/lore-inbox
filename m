Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVBLRqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVBLRqn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 12:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVBLRqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 12:46:43 -0500
Received: from s-utl01-nypop.stsn.com ([199.106.90.52]:2071 "HELO
	s-utl01-nypop.stsn.com") by vger.kernel.org with SMTP
	id S261170AbVBLRqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 12:46:42 -0500
Subject: Re: [rfc/rft] Fujitsu B-Series Lifebook PS/2 TouchScreen driver
From: Arjan van de Ven <arjan@infradead.org>
To: Kenan Esau <kenan.esau@conan.de>
Cc: Vojtech Pavlik <vojtech@suse.cz>, harald.hoyer@redhat.de,
       lifebook@conan.de, dtor_core@ameritech.net,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
In-Reply-To: <1108227679.12327.24.camel@localhost>
References: <20050211201013.GA6937@ucw.cz>
	 <1108227679.12327.24.camel@localhost>
Content-Type: text/plain
Date: Sat, 12 Feb 2005 12:46:32 -0500
Message-Id: <1108230392.4056.100.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Feb 2005 17:46:35.0724 (UTC) FILETIME=[CBE888C0:01C5112A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-02-12 at 18:01 +0100, Kenan Esau wrote:

> Second thing is that I am not shure that it is a good idea to integrate
> the lbtouch-support into the psmouse-driver since there is no real way
> of deciding if the device you are talking to is REALLY a
> lifebook-touchsreen or not. 
...
> IMHO the driver should be standalone and the user should decide which
> driver he wants to use. As default the touchscreen-functionality will be
> disabled and only the quick-point device will work like a normal
> PS2-mouse.

I just want to point out that this is a problem for distributions and
for not-so-technical users.

Is there *really*  no way to know if you're on a lifebook? Can't you use
say the DMI identification mechanism to find this out ? If so, I think
integrating into the regular driver very much is the right thing to
do... it makes things JustWork(tm) for users without any need for manual
configuration (which also makes distribution makers happy).




