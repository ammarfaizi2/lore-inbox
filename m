Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbTKQUku (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 15:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbTKQUku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 15:40:50 -0500
Received: from main.gmane.org ([80.91.224.249]:32143 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261732AbTKQUkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 15:40:49 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Vedran Rodic <vedran@quark.fsb.hr>
Subject: Re: Kernel 2.6.0-test9, deadlock using usb-storage, eventually memory allocation bug
Date: Mon, 17 Nov 2003 21:28:33 +0100
Message-ID: <pan.2003.11.17.20.28.32.434739@quark.fsb.hr>
References: <1069097145.3fb920b9a10b1@fvs.dnsalias.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity. (Debian GNU/Linux))
Cc: linux-usb-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Nov 2003 20:25:45 +0100, Maximilian Mehnert wrote:

> If anybody is willing to help me I  would gratefully send her/him all my logs
> and my previous correspondence on this topic :)


I think you may be hitting the same problem I did some time ago.

Please see
http://www.mail-archive.com/linux-usb-devel%40lists.sourceforge.net/msg17080.html


Try the attached patch Alan Stern made. You'll have to add a "," to the
end of "+      .max_sectors =                  240" line. 

Alan, this patch should be in queue for 2.6.0, right?



Vedran Rodic

