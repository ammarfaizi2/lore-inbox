Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751551AbWIZQpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbWIZQpL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 12:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751553AbWIZQpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 12:45:11 -0400
Received: from mx.pathscale.com ([64.160.42.68]:20908 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751551AbWIZQpJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 12:45:09 -0400
Subject: Re: When will the lunacy end? (Was Re: [PATCH] uswsusp: add
	pmops->{prepare,enter,finish} support (aka "platform mode"))
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Stefan Seyfried <seife@suse.de>, linux-kernel@vger.kernel.org,
       "Rafael J. Wysocki" <rjw@sisk.pl>
In-Reply-To: <20060925232151.GA1896@elf.ucw.cz>
References: <20060925071338.GD9869@suse.de>
	 <1159220043.12814.30.camel@nigel.suspend2.net>
	 <20060925144558.878c5374.akpm@osdl.org> <20060925224500.GB2540@elf.ucw.cz>
	 <20060925160648.de96b6fa.akpm@osdl.org>  <20060925232151.GA1896@elf.ucw.cz>
Content-Type: text/plain
Date: Tue, 26 Sep 2006 09:45:08 -0700
Message-Id: <1159289108.9652.10.camel@chalcedony.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-26 at 01:21 +0200, Pavel Machek wrote:

> Your machines spend 15 seconds in drivers? Ouch, I did not realize
> _that_. 

My laptop spends some substantial amount of time aimilarly mooning me
when I suspend it.  The phases are timed roughly like this:

16 seconds doing things to devices
2 seconds memory
4 seconds doing more things to devices
10 seconds writing to disk

(Yes, it takes about 32 seconds to suspend.)

	<b

