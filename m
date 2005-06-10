Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbVFJWqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbVFJWqW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 18:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbVFJWpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 18:45:13 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:36313
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261341AbVFJWm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 18:42:58 -0400
Date: Fri, 10 Jun 2005 15:42:48 -0700 (PDT)
Message-Id: <20050610.154248.130848042.davem@davemloft.net>
To: willy@w.ods.org
Cc: xschmi00@stud.feec.vutbr.cz, alastair@unixtrix.com,
       linux-kernel@vger.kernel.org
Subject: Re: BUG: Unusual TCP Connect() results.
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050610222645.GA1317@pcw.home.local>
References: <42A9C607.4030209@unixtrix.com>
	<42A9BA87.4010600@stud.feec.vutbr.cz>
	<20050610222645.GA1317@pcw.home.local>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willy TARREAU <willy@w.ods.org>
Date: Sat, 11 Jun 2005 00:26:45 +0200

> It is documented in RFC793 (p30) as the simultaneous connection initation
> from 2 clients, although this mode has never been implemented by any
> mainline OS (to my knowledge) as it has no real use and poses security
> problems (eases spoofing a lot).

BSD (and thus BSD derivatives) and Linux have has it since
day one.  I guess it depends upon your definition of
"mainline OS". :-)

This is not a new feature.
