Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWE3OF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWE3OF5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 10:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWE3OF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 10:05:56 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:52567 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932250AbWE3OF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 10:05:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a0T4EA95So8rrQADpSDKGgwzJsDpyZ45uTElfYzS1TILMYNkBUoEkSQWbPgfkF+ACIPUC2fSOGkEyNQRnuzjBKAcQ2p0TJ92iqUaGTPHShCBjRoYzmDuWzeg1tIs22gsHfoFw8eXvU6whTQXvv3qhrbz5X2f8t9xUCxlc4+M16A=
Message-ID: <20f65d530605300705l60bfcca7k47a41c95bf42a0ef@mail.gmail.com>
Date: Wed, 31 May 2006 02:05:44 +1200
From: "Keith Chew" <keith.chew@gmail.com>
To: "Erik Mouw" <erik@harddisk-recovery.com>
Subject: Re: IO APIC IRQ assignment
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060530135017.GD5151@harddisk-recovery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20f65d530605300521q1d56c3a3t84be3d92f1df0c14@mail.gmail.com>
	 <20060530135017.GD5151@harddisk-recovery.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Erik

> That sounds like a nice MythTV box to me :)
>

Yes it is! We are using the box as a video surveillance unit for the
automotive industry (eg trains, buses). We are using the USB for WIFI,
which is causing pain with the bttv drivers in IRQ sharing mode.
Increasing the PCI latency of the bttv allow it to not give up the IRQ
that often to the WIFI. The bttv FAQ did mention that the drivers
works "most of the time" in IRQ sharing, I guess we are seeing the
random freezes because our application is 24x7.

>
> Or the engineer means that in legacy PIC mode the IRQs are shared, but
> in APIC mode they can be separated. That is a different thing, cause in
> that case the IRQ lines are not physically connected, but put together
> in PIC mode and can again be separated by using APIC mode.
>

Ah, you could be right here. In the BIOS, there an option to
enable/disable APIC, which corresponds to what you are suggesting
above.

Unfortunately, we have tried all the options we know to separate the
IRQs in IO APIC mode, but to no avail. Next, we will be testing the
unit in Windows to verify the engineer's claims.

Thanks again for taking the time to respond to my post.

Regards
Keith
