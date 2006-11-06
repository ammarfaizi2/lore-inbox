Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753253AbWKFPws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253AbWKFPws (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 10:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753267AbWKFPws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 10:52:48 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:31473 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1753253AbWKFPws (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 10:52:48 -0500
Message-ID: <454F5A59.8010309@cfl.rr.com>
Date: Mon, 06 Nov 2006 10:52:57 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>
CC: Brent Baccala <cosine@freesoft.org>, linux-kernel@vger.kernel.org
Subject: Re: async I/O seems to be blocking on 2.6.15
References: <Pine.LNX.4.64.0611030311430.25096@debian.freesoft.org> <20061103122055.GE13555@kernel.dk> <Pine.LNX.4.64.0611031049120.7173@debian.freesoft.org> <20061103160212.GK13555@kernel.dk> <Pine.LNX.4.64.0611031214560.28100@debian.freesoft.org> <20061105121522.G <20061106104350.GR13555@kernel.dk>
In-Reply-To: <20061106104350.GR13555@kernel.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Nov 2006 15:52:56.0747 (UTC) FILETIME=[A08D37B0:01C701BB]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14796.003
X-TM-AS-Result: No--6.695900-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> Yeah, I'm afraid so. We really should be returning EAGAIN or something
> like that for the congested condition, though.

How would user mode know when it was safe to retry the request?


