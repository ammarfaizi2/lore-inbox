Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264225AbUE3RWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264225AbUE3RWs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 13:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264228AbUE3RWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 13:22:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63132 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264225AbUE3RWo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 13:22:44 -0400
Message-ID: <40BA1857.7020708@pobox.com>
Date: Sun, 30 May 2004 13:22:31 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: PATCH: First cut at fixing the 3c59x power mismanagment
References: <20040530105305.GA5312@devserv.devel.redhat.com>
In-Reply-To: <20040530105305.GA5312@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> In Fedora 2 there have been lots of problem reports with 3c59x mostly 
> apparently linked to power handling errors. In particular tools query the
> MII state of down interfaces.
> 
> The changes here
> 
> -	Power the chip up when doing MII, much as e100 does
> -	Fix a case where the error handling issued commands to the chip
> 	while it was in D3 state
> -	Fixed a case where shutdown handling issued commands to the chip
> 	while it was in D3 state
> 
> I don't have enough suitable hardware to do good coverage testing on these
> changes so test reports would be appreciated.


Initial review of the patch looks good, FWIW.

Thanks for poking at this,

	Jeff


