Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265574AbTGBXGQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 19:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265537AbTGBXAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 19:00:00 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:52642 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265135AbTGBW7d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 18:59:33 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 2 Jul 2003 16:06:09 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: jjs <jjs@tmsusa.com>
cc: root@chaos.analogic.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: DHCP vs Cable Modem
In-Reply-To: <3F036467.1010504@tmsusa.com>
Message-ID: <Pine.LNX.4.55.0307021604410.4840@bigblue.dev.mcafeelabs.com>
References: <Pine.LNX.4.53.0307021627070.26905@chaos> <3F036467.1010504@tmsusa.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jul 2003, jjs wrote:

> Richard B. Johnson wrote:
>
> >Sorry about BW. Anybody know how to configure a cable modem?
> >I have one. I connect it to the cable. I set Linux up for
> >DHCP. I end up with a dynamic IP address, a network mask,
> >a broadcast address, a default route, and even a name-server.
> >
> >I can ping the name-server. However, I can't telnet or use
> >a Web Crawler. The thing works fine with WIN/2000/Prof. The
> >ISP says they only support Windows. Since I have all the
> >"hooks" working, how do I find a default route that will
> >route my packets to bypass their stuff?
> >
> Your symptoms suggest that your are basically up and running but perhaps
> have name resolution issues.
>
> Lack of information about your setup prevents me from offering any
> further advice.

This shouldn't be in lkml though. You need to set /etc/resolv.conf. I had
the same problem with comcast. Just dig for comcast.net NSs and add them
in your /etc/resolv.conf



- Davide

