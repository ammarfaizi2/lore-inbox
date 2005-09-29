Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbVI2VyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbVI2VyL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 17:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbVI2VyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 17:54:10 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:22955 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932418AbVI2VyJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 17:54:09 -0400
Subject: Re: [PATCH 2.6.14-rc2] aoe [1/3]: explicitly set minimum packet
	length to ETH_ZLEN
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Ed L. Cashin" <ecashin@coraid.com>
Cc: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
In-Reply-To: <87wtkzbz5z.fsf@coraid.com>
References: <87wtkzbz5z.fsf@coraid.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 29 Sep 2005 23:21:31 +0100
Message-Id: <1128032491.9290.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-09-29 at 12:45 -0400, Ed L. Cashin wrote:
> Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
> 
> Explicitly set the minimum packet length to ETH_ZLEN and zero the
> packet data.

You still haven't explained why this is neccessary. The drivers should
be doing it for you.

