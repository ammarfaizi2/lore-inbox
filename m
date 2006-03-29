Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbWC2W3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWC2W3M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 17:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbWC2W3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 17:29:12 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:2281 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751049AbWC2W3L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 17:29:11 -0500
Message-ID: <442B0A2E.5090407@pobox.com>
Date: Wed, 29 Mar 2006 17:29:02 -0500
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

applied


