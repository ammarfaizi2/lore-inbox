Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264943AbUE0SWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264943AbUE0SWS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 14:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264933AbUE0SWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 14:22:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53726 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264949AbUE0SVx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 14:21:53 -0400
Message-ID: <40B631B3.4000902@pobox.com>
Date: Thu, 27 May 2004 14:21:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@ruslug.rutgers.edu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, prism54-devel@prism54.org
Subject: Re: [PATCH 4/14 linux-2.6.7-rc1] prism54: add support for avs header
 in
References: <20040524083146.GE3330@ruslug.rutgers.edu>
In-Reply-To: <20040524083146.GE3330@ruslug.rutgers.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luis R. Rodriguez wrote:
> diff -u -r1.31 -r1.33
> --- linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_eth.c	18 Mar 2004 15:27:44 -0000	1.31
> +++ linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_eth.c	19 Mar 2004 23:03:58 -0000	1.33
> @@ -1,4 +1,4 @@
> -/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_eth.c,v 1.31 2004/03/18 15:27:44 ajfa Exp $
> +/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_eth.c,v 1.33 2004/03/19 23:03:58 ajfa Exp $


Please remove CVS substitions from your code, they cause endless patch 
rejects if I choose to apply (for example) 10 out of 14 patches.

	Jeff


