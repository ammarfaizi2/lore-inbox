Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbVLHTjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbVLHTjg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 14:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbVLHTjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 14:39:36 -0500
Received: from [81.2.110.250] ([81.2.110.250]:27061 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932226AbVLHTjf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 14:39:35 -0500
Subject: Re: 2.6.{14,15-rc4} harddrive cache not detected
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sebastian =?ISO-8859-1?Q?K=E4rgel?= <mailing@wodkahexe.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051208194408.77e17f64.mailing@wodkahexe.de>
References: <20051208194408.77e17f64.mailing@wodkahexe.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Thu, 08 Dec 2005 19:38:53 +0000
Message-Id: <1134070734.17102.65.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-12-08 at 19:44 +0100, Sebastian Kärgel wrote:
> According to the manufactor the new harddrive should have 8mb cache.
> /proc/ide/ide0/hda/cache also show "0"

Zero doesn't mean "no cache" in that field it means it hasnt provided
the info. I wouldnt worry too much - we dont actually use the cache info
for anything but pretty reporting.

