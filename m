Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289011AbSAUCp0>; Sun, 20 Jan 2002 21:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289013AbSAUCpR>; Sun, 20 Jan 2002 21:45:17 -0500
Received: from pizda.ninka.net ([216.101.162.242]:44712 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289011AbSAUCpJ>;
	Sun, 20 Jan 2002 21:45:09 -0500
Date: Sun, 20 Jan 2002 18:43:18 -0800 (PST)
Message-Id: <20020120.184318.13746427.davem@redhat.com>
To: davej@suse.de
Cc: martin.macok@underground.cz, linux-kernel@vger.kernel.org, ak@muc.de
Subject: Re: [andrewg@tasmail.com: remote memory reading through tcp/icmp]
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020121031211.B29830@suse.de>
In-Reply-To: <20020121015209.A26413@sarah.kolej.mff.cuni.cz>
	<20020120.175204.18636524.davem@redhat.com>
	<20020121031211.B29830@suse.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Dave Jones <davej@suse.de>
   Date: Mon, 21 Jan 2002 03:12:11 +0100

   On Sun, Jan 20, 2002 at 05:52:04PM -0800, David S. Miller wrote:
    > -	icmp_param.offset=skb_in->nh.raw - skb_in->data;
    > +	icmp_param.offset=skb_in->data - skb_in->nh.raw;
   
    With this fix, I'm seeing lots of really strange things happen.
    When eth0 comes up, the box slows down to a crawl.
    5 minutes later when it gets to starting NIS, the
    broadcast address is bombed with portmap connections.

Andi?
