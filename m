Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270172AbTGMIVa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 04:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270173AbTGMIV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 04:21:29 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:35771
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270172AbTGMIV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 04:21:29 -0400
Subject: Re: 2.4.22-pre3 : SoundBlaster IDE interface missing
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ben Castricum <lk@bencastricum.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <001501c34896$baddd3e0$0802a8c0@pc>
References: <000901c343df$9165ed10$0802a8c0@pc>
	 <1057578275.2749.11.camel@dhcp22.swansea.linux.org.uk>
	 <001501c34896$baddd3e0$0802a8c0@pc>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058085216.31911.29.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Jul 2003 09:33:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-07-12 at 17:57, Ben Castricum wrote:
> I took a look at it myself as well and it seems that the code was just
> removed. This patch restores a couple of line from pre2 and fixes the
> problem for me. It's diffed againts the current bk-2.4 tree.

It was moved to a new style of initializer. Your change will make it work
right I think because the problem was initialization ordering.

