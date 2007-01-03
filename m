Return-Path: <linux-kernel-owner+w=401wt.eu-S1751015AbXACSHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbXACSHv (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 13:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbXACSHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 13:07:51 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:37191 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbXACSHu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 13:07:50 -0500
Date: Wed, 3 Jan 2007 09:54:22 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Shlomi Fish <shlomif@iglu.org.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc3] qconf Search Dialog
Message-Id: <20070103095422.f89a88e5.randy.dunlap@oracle.com>
In-Reply-To: <200701031954.36440.shlomif@iglu.org.il>
References: <200701031954.36440.shlomif@iglu.org.il>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2007 19:54:36 +0200 Shlomi Fish wrote:

> Hi all!
> 
> [ I'm not subscribed to this list so please CC me on your replies. ]
> 
> This is a new version of the patch that adds a search dialog to the 
> kernel's "make xconfig" configuration applet.

Would you just clarify one thing, please.
xconfig already has a search dialog.  Does this one replace it
or fix it or what?

Thanks.

> Changes in this release include:
> 
> 1. Implemented regular expression querying. The GUI includes an option for a 
> keywords based query, which is not supported yet.
> 
> 2. Fixed the fact that the top categories in the QListView do not have a 
> visible 
> [+] sign next to them to expand them. (Albeit they are expanded upon a double 
> click).
> 
> 3. Now resizing the dialog to a larger default size.
> 
> To do is:
> 
> 1. Make sure double clicking an end-item opens and highlights it in the main 
> application.
> 
> 2. Eliminate the weird black-outlined rectangle that appears in the top-left 
> corner of the dialog.
> 
> --------
> 
> The patch was tested against kernel 2.6.20-rc3.
