Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWAJHJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWAJHJV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 02:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWAJHJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 02:09:21 -0500
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:62801 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932065AbWAJHJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 02:09:20 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 12/24] pcspkr: register with driver core as a platfrom device
Date: Tue, 10 Jan 2006 02:09:17 -0500
User-Agent: KMail/1.8.3
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       mikey@neuling.org
References: <20060107171559.593824000.dtor_core@ameritech.net> <200601100148.38228.dtor_core@ameritech.net> <1136876653.10235.7.camel@localhost.localdomain>
In-Reply-To: <1136876653.10235.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601100209.17721.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 January 2006 02:04, Benjamin Herrenschmidt wrote:
> 
> > Having platform code instantiate platform devices would be great but I
> > wonder how it will look like on x86 where we don't have a way to enumerate
> > devices. ACPI might do it but I am not sure if all DSDTs describe beepers...
> 
> I don't know the gory details about x86 so I'll let others decide what
> to do there... can't it start by instanciating it unconditionally +/-
> maybe a kernel command line to "skip" it in case the hw is really not
> legacy ?
>

Maybe.. I need to think about it...

-- 
Dmitry
