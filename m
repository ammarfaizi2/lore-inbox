Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVCCErX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVCCErX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 23:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbVCCErA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 23:47:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21472 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261265AbVCCEqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 23:46:44 -0500
Message-ID: <4226969E.5020101@pobox.com>
Date: Wed, 02 Mar 2005 23:46:22 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>, torvalds@osdl.org, akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>	<42264F6C.8030508@pobox.com>	<20050302162312.06e22e70.akpm@osdl.org>	<42265A6F.8030609@pobox.com>	<20050302165830.0a74b85c.davem@davemloft.net>	<422674A4.9080209@pobox.com>	<Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>	<42268749.4010504@pobox.com> <20050302200214.3e4f0015.davem@davemloft.net> <42268F93.6060504@pobox.com>
In-Reply-To: <42268F93.6060504@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If Linus/DaveM really don't like -pre/-rc naming, I think 2.6.x.y is 
preferable to even/odd.

Just create a 2.6.X repo at each release.  For bug fixes to 2.6.X, 
commit to this repo, then pull into linux-2.6.  For everything else, 
pull straight into linux-2.6.

The linux-2.6 repo would be upstream, and linux-2.6.X repo would be 
where bugfix-only releases come from.

	Jeff



