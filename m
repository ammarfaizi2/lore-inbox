Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWJIDfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWJIDfc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 23:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWJIDfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 23:35:31 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:46761 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932226AbWJIDf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 23:35:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=JdATSDoV1B48l6RHUckdPNUhf65UAhintgJcoNz4W7whiLl8GDrcey6Aa6b89CCRVjcW6drAUkiVAFubo8n2k2c4uvS1j7MOjLq7l3N4mcPga5zyjYJNcwBBHDFKghi6tAOKZRMlltm06izThH/i6B9fNXL9OmAi/V7wFKBe+L4=
Message-ID: <4529C38A.2000708@gmail.com>
Date: Mon, 09 Oct 2006 11:35:38 +0800
From: Liyu <raise.sail@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Anssi Hannula <anssi.hannula@gmail.com>
CC: "raise.sail@gmail.com" <raise.sail@gmail.com>, greg <greg@kroah.com>,
       Randy Dunlap <rdunlap@xenotime.net>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>,
       linux-usb-devel <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] [PATCH] usb/hid: The HID Simple Driver	Interface
 0.3.2 (core)
References: <200609291624123283320@gmail.com>		<20060929095913.f1b6f79d.rdunlap@xenotime.net>	<d120d5000609291035q7dad5f7fqcb38d4d8b3b211e5@mail.gmail.com>	<45286B85.90402@gmail.com> <452948AD.8030600@gmail.com>
In-Reply-To: <452948AD.8030600@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anssi Hannula wrote:
> One possibility is to do that with symbol_request() and friends. That
> would not be pretty though, imho.
>
> DVB subsystem uses that currently to load frontend modules dynamically,
> see dvb_attach() and dvb_frontend_detach() in
> drivers/media/dvb/dvb-core/dvbdev.h and
> drivers/media/dvb/dvb-core/dvb_frontend.c.
>
>   
This means also can load module dynamically. In apparently, I think it
have two weaknesses:
   
    1. It require module have one exported symbol at least.
    2. We must handle life cycle of module by myself.

Is it right?

Goodluck

-Liyu
