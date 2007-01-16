Return-Path: <linux-kernel-owner+w=401wt.eu-S932125AbXAPD2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbXAPD2r (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 22:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbXAPD2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 22:28:47 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:51659
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S932105AbXAPD2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 22:28:46 -0500
Date: Mon, 15 Jan 2007 19:28:46 -0800 (PST)
Message-Id: <20070115.192846.85406756.davem@davemloft.net>
To: ahendry@tusc.com.au
Cc: linux-x25@vger.kernel.org, eis@baty.hanse.de, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH] X.25 Add missing sock_put in x25_receive_data
From: David Miller <davem@davemloft.net>
In-Reply-To: <1168295537.5460.30.camel@localhost>
References: <1168295537.5460.30.camel@localhost>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: ahendry <ahendry@tusc.com.au>
Date: Tue, 09 Jan 2007 09:32:17 +1100

> __x25_find_socket does a sock_hold.
> This adds a missing sock_put in x25_receive_data.
> 
> Signed-off-by: Andrew Hendry <andrew.hendry@gmail.com>

Applied, thanks a lot.
