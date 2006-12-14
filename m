Return-Path: <linux-kernel-owner+w=401wt.eu-S1751934AbWLNXYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbWLNXYc (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 18:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbWLNXYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 18:24:32 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:37943
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751826AbWLNXYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 18:24:31 -0500
Date: Thu, 14 Dec 2006 15:24:17 -0800 (PST)
Message-Id: <20061214.152417.55722558.davem@davemloft.net>
To: nuxdoors@cegetel.net
Cc: vojtech@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19.1] sunkbd.c: fix sunkbd_enable(sunkbd, 0);
 obvious
From: David Miller <davem@davemloft.net>
In-Reply-To: <4581B330.5040106@cegetel.net>
References: <4581B330.5040106@cegetel.net>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: nuxdoors@cegetel.net
Date: Thu, 14 Dec 2006 21:25:20 +0100

> "sunkbd_enable(sunkbd, 0);" has no effect. Adding "sunkbd->enabled = enable" in sunkbd_enable (obvious)
> 
> Signed-off-by: Fabrice Knevez <nuxdoors@cegetel.net>

Applied, thanks.
