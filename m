Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbTLIWdg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 17:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263497AbTLIWdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 17:33:36 -0500
Received: from massena-4-82-67-197-146.fbx.proxad.net ([82.67.197.146]:4994
	"EHLO perso.free.fr") by vger.kernel.org with ESMTP id S263448AbTLIWdf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 17:33:35 -0500
From: Duncan Sands <baldrick@free.fr>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: Tue, 9 Dec 2003 23:33:33 +0100
User-Agent: KMail/1.5.4
Cc: Alan Stern <stern@rowland.harvard.edu>, Vince <fuzzy77@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, mfedyk@matchmail.com,
       zwane@holomorphy.com, linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
References: <Pine.LNX.4.44L0.0312091638140.7053-100000@ida.rowland.org> <200312092307.04924.baldrick@free.fr> <3FD64BD9.1010803@pacbell.net>
In-Reply-To: <3FD64BD9.1010803@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312092333.33562.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It occurred on system shutdown - so I guess the module was unloaded.
> > Maybe the bus reference counting is borked.
>
> Various folk have reported similar problems on system shutdown
> before, and the simple fix has been not to clean up so aggressively.

?

> What puzzled me was that a normal "rmmod" wouldn't give the
> same symptoms -- but the same codepaths could oops in certain
> system shutdown scenarios.

Duncan.
