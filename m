Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbTFFPTh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 11:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbTFFPTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 11:19:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:17132 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261868AbTFFPTf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 11:19:35 -0400
Date: Fri, 06 Jun 2003 08:30:33 -0700 (PDT)
Message-Id: <20030606.083033.82102202.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: jgarzik@pobox.com, margitsw@t-online.de, linux-kernel@vger.kernel.org
Subject: Re: PCI cache line messages 2.4/2.5
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1054913267.17190.10.camel@dhcp22.swansea.linux.org.uk>
References: <1054842521.15275.45.camel@dhcp22.swansea.linux.org.uk>
	<20030605.221108.78711828.davem@redhat.com>
	<1054913267.17190.10.camel@dhcp22.swansea.linux.org.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: 06 Jun 2003 16:27:48 +0100
   
   The compaq driver isnt loaded at this point. There is a window of
   opportunity
   
Point.  But %99 of the time it's the dang BIOS doing something wrong.
We SHOULD take care of that case, and whether it's nice to log a
message about it or not is a seperate matter.
