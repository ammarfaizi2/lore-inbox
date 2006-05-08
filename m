Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbWEHRuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbWEHRuj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 13:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWEHRui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 13:50:38 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:16987 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932478AbWEHRuh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 13:50:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SrVEpRy1gzuqmd0CITyr672G/qTkw330XIxVA/3D6AjcdFwK5y+94USq92j/YsfoSacqD70C01gEc+3jRK4E3FNR8TPQNv6tOC3BFm1J38hlSKxUGxAPpuQJa+ls7aUHk1OrBKHQ9JXW5pWmhiGNmXZ6USr9ej8US88aNlBAUy0=
Message-ID: <3feffd230605081050x104461fcj76f2821cfc311a6e@mail.gmail.com>
Date: Tue, 9 May 2006 01:50:36 +0800
From: "Wong Edison" <hswong3i@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] TCP congestion module: add TCP-LP supporting for 2.6.16.14
Cc: pavel@suse.cz, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060508.104322.58430929.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3feffd230605062232m1b9a3951h6d21071cdacc890f@mail.gmail.com>
	 <20060508112915.GB4162@ucw.cz>
	 <20060508.104322.58430929.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Or, just include it, and select it with the TCP_CONGESTION socket
> option when you want it.  Sorry, this does require app modifications.

i would like to have more information about this
so within the app
after create the socket
then call setsockopt (!?)
to set the TCP_CONGESTION into "lp" (in my case) ??

is that means the socket's congestion algorithm will then be what i set ??
in this socket within this app only ??

how about the socket create by "accept" ??
it will still use the default ?? or as listen socket ??

thanks
