Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbVIMJaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbVIMJaU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 05:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbVIMJaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 05:30:20 -0400
Received: from webapps.arcom.com ([194.200.159.168]:41234 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S932458AbVIMJaT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 05:30:19 -0400
Message-ID: <43269C1B.4090608@cantab.net>
Date: Tue, 13 Sep 2005 10:30:03 +0100
From: David Vrabel <dvrabel@cantab.net>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Watson <tsw@johana.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Pruning the source tree (idea)
References: <4324A817.8050004@johana.com>
In-Reply-To: <4324A817.8050004@johana.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Sep 2005 09:29:18.0515 (UTC) FILETIME=[9D888030:01C5B845]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Watson wrote:
> 
> Have a top level make target that prunes (deletes summarily) the
> unwanted architectures from the source tree.

NAK.  I think you underestimate the number people who'd do something like:

1. make prune ARCH=foo
2. make oldconfig ARCH=bar
3. Complain to l-k, their vendor etc. that the kernel is busted.

David Vrabel
