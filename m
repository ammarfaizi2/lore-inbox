Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964772AbWEBUk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbWEBUk5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 16:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbWEBUk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 16:40:57 -0400
Received: from xproxy.gmail.com ([66.249.82.198]:33905 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964772AbWEBUk4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 16:40:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AoQf6H6gbQ3dEwfOuoplKRBcIejvgSauPKUd3nGKDbDAyvb/b5u/+q66m9+xJCzemlsdzVws0M7NXiZzsrZm7QxIqvaddnw80z3Rv0uDPnESBXt6kJPYMhGhfmH4TsRdKfEc5hxK0bHbcTz3V8BveNhsyUnBYpv8/tgeVjJpAyQ=
Message-ID: <df47b87a0605021340v1c3901e9r17eb3c69034b7487@mail.gmail.com>
Date: Tue, 2 May 2006 16:40:56 -0400
From: "Ioan Ionita" <opslynx@gmail.com>
To: "Michael Helmling" <supermihi@web.de>
Subject: Re: New, yet unsupported USB-Ethernet adaptor
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <200605022002.15845.supermihi@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200605022002.15845.supermihi@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/06, Michael Helmling <supermihi@web.de> wrote:
> Thank you very much for the immediate answer.
> I applied the patch  - well, I had to do this manually, for some reason, I
> assume bad formatting in my mail program, patch -p0 < patch1 didn't work. Or
> am I using the wrong command?

You shoud use patch -p1< patch

> Anyway, I changed the lines manually, and now I can compile and load the
> module.
> If I load the module, dmesg gives:
>
> usbcore: registered new driver <NULL>
>
> Then plugging in the adaptor:
>
> usb 2-10: new high speed USB device using ehci_hcd and address 5
> usb 2-10: configuration #1 chosen from 1 choice
>
> But no eth1 shows up, and module loading and plugging the device seem to be
> independent. I manually loaded usbnet but it didn't help.
> Sorry, I really have no experience with kernel or usb development. ;)

Me neither. It was a quick & dirty patch, I must have missed
something. I'll toy around with it some more. Maybe someone more
experienced could take a look? :)


P.S In the future, make sure you use reply-to-all. Thanks
