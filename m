Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbULRRo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbULRRo5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 12:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbULRRo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 12:44:57 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:40459 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261204AbULRRo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 12:44:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=m4txqUNb6s97ID1S6ZPPg6yZK9VDo7kBLP5AR5yyd2DEQi9yLSzCPPZP/bVWlwjVSjtIVbSI0hY+JcHswRNT6fzUg5TrigSCjVMt3U87dwLvjcQnE0d1p6A6IKJlX1TgKggUwyLamYmBI4UKWAg9YLAp2JknqtJYQNE2MJIG1SE=
Message-ID: <d4b385204121809442596e936@mail.gmail.com>
Date: Sat, 18 Dec 2004 17:44:54 +0000
From: Mikkel Krautz <krautz@gmail.com>
Reply-To: Mikkel Krautz <krautz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] hid-core: Configurable USB HID Mouse Interrupt Polling Interval
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz, greg@kroah.com
In-Reply-To: <1103384445.8765.1.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1103335970.15567.15.camel@localhost>
	 <20041218012725.GB25628@kroah.com> <41C46B4D.5040506@gmail.com>
	 <1103384445.8765.1.camel@pegasus>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Dec 2004 16:40:44 +0100, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Mikkel,
> 
> > @@ -1910,6 +1916,7 @@
> >
> >  module_init(hid_init);
> >  module_exit(hid_exit);
> > +module_param(hid_mouse_polling_interval, int, 644);
> 
> I think the use of module_param_named() makes more sense here.
> 
> Regards
> 
> Marcel
> 
> 

Thanks, I'll change it. Do you think I should add a MODULE_PARM_DESC too?

Mikkel
