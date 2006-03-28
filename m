Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWC1UtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWC1UtG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 15:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbWC1UtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 15:49:06 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:43967 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932210AbWC1UtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 15:49:05 -0500
Message-ID: <4429A134.3060800@pobox.com>
Date: Tue, 28 Mar 2006 15:48:52 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Roger Luethi <rl@hellgate.ch>
CC: Andrew Morton <akpm@osdl.org>, vda@ilport.com.ua, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] via-rhine: link state fix
References: <20060328185356.GA22278@k3.hellgate.ch>
In-Reply-To: <20060328185356.GA22278@k3.hellgate.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.5 (---)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-3.5 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Luethi wrote:
> Problems with link state detection have been reported several times in the
> past months.
> 
> Denis Vlasenko did all the work tracking it down. Jeff Garzik suggested the
> proper place for the fix.
> 
> When using the mii library, the driver needs to check mii->force_media
> and set dev->state accordingly.
> 
> Roger
> 
> Signed-off-by: Roger Luethi <rl@hellgate.ch>

ACK, will apply this...


