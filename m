Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161042AbVIPPfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161042AbVIPPfV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 11:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161044AbVIPPfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 11:35:21 -0400
Received: from [81.2.110.250] ([81.2.110.250]:1415 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1161042AbVIPPfU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 11:35:20 -0400
Subject: Re: Lost keyboard on Inspiron 8200 at 2.6.13
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: dtor_core@ameritech.net
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       caphrim007@gmail.com
In-Reply-To: <d120d500050916082519c660e6@mail.gmail.com>
References: <432A4A1F.3040308@gmail.com>
	 <200509152357.58921.dtor_core@ameritech.net>
	 <20050916025356.0d5189a6.akpm@osdl.org>
	 <d120d500050916082519c660e6@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 16 Sep 2005 17:00:49 +0100
Message-Id: <1126886449.17038.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-09-16 at 10:25 -0500, Dmitry Torokhov wrote:
> Interdependencies between ACPI, PNP, USB Legacy emulation and I8042 is
> very delicate and quite often changes in ACPI/PNP break that balance.
> USB legacy emulation is just evil. We need to have "usb-handoff" thing
> enabled by default, it fixes alot of problems.

I would definitely agree with this. There are very few, if any, cases
usb handoff doesn't work now that the Nvidia problems are fixed.


