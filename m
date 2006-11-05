Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422825AbWKEXie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422825AbWKEXie (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 18:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422822AbWKEXie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 18:38:34 -0500
Received: from stinky.trash.net ([213.144.137.162]:7342 "EHLO stinky.trash.net")
	by vger.kernel.org with ESMTP id S1422812AbWKEXid (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 18:38:33 -0500
Message-ID: <454E75E6.7010500@trash.net>
Date: Mon, 06 Nov 2006 00:38:14 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: joro-lkml@zlug.org, jdi@l4x.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/02 V3] net/ipv6: seperate sit driver to extra module
References: <45301CB3.4060803@l4x.org>	<20061014093255.GA4646@zlug.org>	<454E671B.2090302@trash.net> <20061105.152718.88476049.davem@davemloft.net>
In-Reply-To: <20061105.152718.88476049.davem@davemloft.net>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote:
> Would you like me to apply this or is this a temp workaround
> for folks?

Please apply it. I usually build things as module if possible,
which in this case caused my tunnel to break. This will
probably happen to others as well.

