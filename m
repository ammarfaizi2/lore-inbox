Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262723AbVCDAfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262723AbVCDAfO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 19:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262813AbVCDAbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:31:39 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:8964 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262741AbVCDAaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 19:30:08 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][26/26] IB: MAD cancel callbacks from thread
X-Message-Flag: Warning: May contain useful information
References: <2005331520.zA1xypugai2bUq7X@topspin.com>
	<4227A6CF.6080805@pobox.com>
From: Roland Dreier <roland@topspin.com>
Date: Thu, 03 Mar 2005 16:30:03 -0800
In-Reply-To: <4227A6CF.6080805@pobox.com> (Jeff Garzik's message of "Thu, 03
 Mar 2005 19:07:43 -0500")
Message-ID: <52zmxknth0.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 04 Mar 2005 00:30:06.0686 (UTC) FILETIME=[509D67E0:01C52051]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Jeff> don't add casts to a void pointer, that's silly.

Fair enough...

    Jeff> dumb question... why is the lock dropped?  is it just for
    Jeff> the send_handler(), or also for wr_id assigned, kfree, and
    Jeff> wake_up() ?

Not sure... Sean?

 - R.
