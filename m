Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbWFFUgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbWFFUgL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 16:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbWFFUgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 16:36:10 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:60375
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1750966AbWFFUgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 16:36:09 -0400
Message-ID: <4485E723.4070201@microgate.com>
Date: Tue, 06 Jun 2006 15:35:47 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: "Randy.Dunlap" <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [PATCH] fix missing hdlc symbols for synclink drivers
References: <20060603232004.68c4e1e3.akpm@osdl.org>	<20060605230248.GE3963@redhat.com>	<20060605184407.230bcf73.rdunlap@xenotime.net>	<1149622813.11929.3.camel@amdx2.microgate.com> <m3u06yc9mr.fsf@defiant.localdomain>
In-Reply-To: <m3u06yc9mr.fsf@defiant.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
> (i.e., while I don't exactly like the rest of the patch as I think
> enabling gHDLC should enable hw drivers - like with other drivers -
> it would probably work).

If I took that approach then you could never
use the synclink drivers without generic HDLC.

The synclink drivers can be used independent of
the generic HDLC or with generic HDLC depending
on space requirements and application.

If you can provide a patch that continues allowing
that level of flexibility in a way more to
your liking, then please post it and I'll have a look.

-- 
Paul Fulghum
Microgate Systems, Ltd.
