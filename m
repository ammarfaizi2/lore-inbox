Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVFMTqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVFMTqk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 15:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVFMTqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 15:46:10 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:50151
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261245AbVFMTpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 15:45:52 -0400
Date: Mon, 13 Jun 2005 12:45:15 -0700 (PDT)
Message-Id: <20050613.124515.104034144.davem@davemloft.net>
To: jesper.juhl@gmail.com
Cc: mru@inprovide.com, rommer@active.by, bernd@firmix.at,
       linux-kernel@vger.kernel.org
Subject: Re: udp.c
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <9a87484905061310237e031c1a@mail.gmail.com>
References: <42AD81FC.9020404@active.by>
	<yw1xu0k2beeh.fsf@ford.inprovide.com>
	<9a87484905061310237e031c1a@mail.gmail.com>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Juhl <jesper.juhl@gmail.com>
Date: Mon, 13 Jun 2005 19:23:36 +0200

> Why not remove the function and audit the code for users (and if any,
> remove them)...? Let's get rid of it instead of having a function sit
> around the only purpose of which is to BUG();

Then if someone breaks that invariant, we'll never find out.

The code is staying, sorry.

