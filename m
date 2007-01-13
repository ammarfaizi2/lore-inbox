Return-Path: <linux-kernel-owner+w=401wt.eu-S1161269AbXAMEbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161269AbXAMEbp (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 23:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161275AbXAMEbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 23:31:44 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:23983 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161269AbXAMEbo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 23:31:44 -0500
Date: Fri, 12 Jan 2007 20:30:59 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Von Wolher <trilight@ns666.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19.1 failing
Message-Id: <20070112203059.78feb871.randy.dunlap@oracle.com>
In-Reply-To: <45A84ACB.5010904@ns666.com>
References: <45A84ACB.5010904@ns666.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Whitelist: TRUE
X-Whitelist: TRUE
X-Brightmail-Tracker: AAAAAQAAAAI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jan 2007 03:58:19 +0100 Von Wolher wrote:

> Hi,
> 
> I just build a 2.6.19.1 vanilla kernel based on the previous config
> (make oldconfig) but for some reason it is not starting. Despite
> following the usual procedure with lilo like many times before it seems
> that lilo tries to boot it and jumps back to the menu screen.

Was your previous config 2.6.18* or 2.6.19?
If it was 2.6.18* and you are using SATA, the config symbol
names for SATA changed and you'll need set them via make *config.

Otherwise we'll probably need more info.

> But selecting the old kernel boots just fine.
> 
> Any one can advise on what could cause such behaviour beside the obvious
>  steps like did i run lilo after kernel compile, check paths ...


---
~Randy
