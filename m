Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263437AbTECVzV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 17:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263438AbTECVzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 17:55:21 -0400
Received: from main.gmane.org ([80.91.224.249]:9391 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263437AbTECVzU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 17:55:20 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kevin Puetz <puetzk@iastate.edu>
Subject: Re: make xconfig & qt
Date: Sat, 03 May 2003 17:07:43 -0500
Message-ID: <b91eh1$geq$1@main.gmane.org>
References: <3EB41C28.2030007@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: KNode/0.7.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniele Pala wrote:

> Hello.
> 
> Sorry for the pretty OT and stupid question, but i just started getting
> interested in the linux kernel, so i downloaded kernel 2.5.68. Trying to
> run 'make xconfig' i got into the message 'you don't have installed
> qt!'...so the xconfig is now dependant from qt? why? what about us poor

Yes, it was rewritten in 2.5 to not suck quite as bad, and now uses Qt.

> guy who only use twm and not kde? isn't qt pretty big and fat? ah well,

Qt != KDE. You only need Qt installed for this. Qt is rather smaller than
the kernel source anyway :-)

I think there's a GTK-based configurator around somewhere too, and you could
probably rewrite a Tk one if so inclined... the configuration actually uses
a library now, so the frontends are decently independent.

> falling back to menuconfig...

Exactly, you still have menuconfig :-)

> thanks for your patience.


