Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283254AbRK2OwF>; Thu, 29 Nov 2001 09:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283258AbRK2Ovz>; Thu, 29 Nov 2001 09:51:55 -0500
Received: from mailbox.egenera.com ([208.51.147.22]:43524 "EHLO
	mailbox.egenera.com") by vger.kernel.org with ESMTP
	id <S283254AbRK2Ovv>; Thu, 29 Nov 2001 09:51:51 -0500
Message-ID: <3C064B56.51E7102A@egenera.com>
Date: Thu, 29 Nov 2001 09:51:02 -0500
From: "Philip R. Auld" <prauld@egenera.com>
Organization: Egenera Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow 'hidden' interfaces in 2.4.x
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Phil Oester wrote on   2001-05-17 20:15:49

>The attached patch (against 2.4.4-ac10) adds the
>/proc/sys/net/ipv4/conf/*/hidden option which is present in 2.2.x series.
>This is somewhat similar to the arp-filter functionality which was added in
>~2.4.4-ac10.  The difference is that this is not dependent upon the routing
>table, it is simply configured using proc fs.
>
>This is particularly useful in load-balanced server farms where loopback
>addresses are configured for direct client-server traffic.  Without this
>patch, Linux will respond to arp requests for the virtual IPs, making
>effective load balancing difficult.


(Patch snipped)


I looked in the archives for any response to Phil's post above, but didn't see
anything.

Does anyone know why this functionality is not included in the 2.4 kernels?

Is there a different way to get this same functionality that _is_ in 2.4.x?

If not then I think this is regression. The 2.4 kernel ought to be at
least as useable as the 2.2 series. In the case of load balancing
it isn't.

Thanks for the info,


Phil



------------------------------------------------------
Philip R. Auld, Ph.D.                  Technical Staff 
Egenera Corp.                        pauld@egenera.com
165 Forest St, Marlboro, MA 01752        (508)786-9444
