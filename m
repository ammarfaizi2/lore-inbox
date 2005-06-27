Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbVF0Ew0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbVF0Ew0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 00:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbVF0Ew0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 00:52:26 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:13986
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261805AbVF0EwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 00:52:23 -0400
Date: Sun, 26 Jun 2005 21:52:16 -0700 (PDT)
Message-Id: <20050626.215216.07640230.davem@davemloft.net>
To: benh@kernel.crashing.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: kbuild warnings with current git
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1119846670.5133.101.camel@gaston>
References: <1119846670.5133.101.camel@gaston>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: kbuild warnings with current git
Date: Mon, 27 Jun 2005 14:31:09 +1000

> net/ipv4/Kconfig:551:warning: type of 'TCP_CONG_BIC' redefined from 'tristate' to 'boolean'
> 
> net/ipv4/Kconfig:92:warning: defaults for choice values not supported

I sent Linus a fix for this an hour ago, it is in his
GIT tree right now.
