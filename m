Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbVFNHsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVFNHsN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 03:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbVFNHsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 03:48:12 -0400
Received: from cantor2.suse.de ([195.135.220.15]:40409 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261306AbVFNHrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 03:47:52 -0400
Message-ID: <42AE8BA4.5020702@suse.de>
Date: Tue, 14 Jun 2005 09:47:48 +0200
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050317
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-hotplug-devel@lists.sourceforge.net,
       Kay Sievers <kay.sievers@vrfy.org>, Greg KH <gregkh@suse.de>,
       Vojtech Pavlik <vojtech@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Input sysbsystema and hotplug
References: <200506131607.51736.dtor_core@ameritech.net> <200506131705.30159.dtor_core@ameritech.net> <42AE8820.2010102@suse.de> <200506140242.08982.dtor_core@ameritech.net>
In-Reply-To: <200506140242.08982.dtor_core@ameritech.net>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On Tuesday 14 June 2005 02:32, Hannes Reinecke wrote:
>>And yes, we should break compability and come up with a clean
>>implementation.
> 
> But those pesky users scream every time we break their mice ;)
> 
>>And as the original input event is an abomination I 
>>don't see the point in keeping compability with a broken interface.
>>
> 
> Why is it abomination (aside from using old mechanism to call
> hotplug)? It looks like it transmits all data necessary to load
> appropriate input handler...
> 
Because there are _two_ events with the name 'input'.
Both run under the same name but carry different information.
One is required to load the module and the other is required to create
the device node.

That's what I call an abomination.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de
