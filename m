Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269289AbUJFPp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269289AbUJFPp7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 11:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269300AbUJFPpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 11:45:44 -0400
Received: from gate.in-addr.de ([212.8.193.158]:62145 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S269314AbUJFPo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 11:44:28 -0400
Date: Wed, 6 Oct 2004 17:44:17 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>,
       "David S. Miller" <davem@davemloft.net>
Cc: joris@eljakim.nl, linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041006154417.GO1542@marowsky-bree.de>
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl> <20041006080104.76f862e6.davem@davemloft.net> <Pine.LNX.4.61.0410061110260.6661@chaos.analogic.com> <20041006082145.7b765385.davem@davemloft.net> <Pine.LNX.4.61.0410061124110.31091@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.61.0410061124110.31091@chaos.analogic.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-10-06T11:29:22, "Richard B. Johnson" <root@chaos.analogic.com> wrote:

> Any code that uses select() on the same file-descriptor
> for several threads is broken. You can't explain away
> a select() problem with a bad-coding example.

Any code which expects non-blocking behaviour without O_NONBLOCK is
broken.

Go away.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX AG - A Novell company

