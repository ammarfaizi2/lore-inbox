Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263488AbTDSWpx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 18:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263489AbTDSWpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 18:45:52 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:58064
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263488AbTDSWpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 18:45:51 -0400
Subject: Re: [PATCH 2.5] report unknown NMI reasons only once
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pascal Schmidt <der.eremit@email.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0304192010020.1306-100000@neptune.local>
References: <Pine.LNX.4.44.0304192010020.1306-100000@neptune.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050789585.3961.15.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 Apr 2003 22:59:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-04-19 at 19:21, Pascal Schmidt wrote:
> Those NMIs happen only rarely when the machine is lightly loaded, but
> under load, I get several of them per second. This quickly makes
> /var/log/messages grow.

I guess they are overheat traps then

> I don't think reporting any of those NMIs more than once provides
> valuable information, so I've cooked up a patch which only reports each
> unknown NMI reason once.

Its sitting there saying "Something is wrong" "Something is still
wrong". By all means kill it on your box, but this is not good for
general consumption. 

