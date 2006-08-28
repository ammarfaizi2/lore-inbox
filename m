Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbWH1Xcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbWH1Xcf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 19:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWH1Xcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 19:32:35 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:11938 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S964893AbWH1Xce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 19:32:34 -0400
Message-ID: <44F37D0F.90706@namesys.com>
Date: Mon, 28 Aug 2006 16:32:31 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Nigel Cunningham <ncunningham@linuxmail.org>
CC: Edward Shishkin <edward@namesys.com>,
       Stefan Traby <stefan@hello-penguin.com>,
       Alexey Dobriyan <adobriyan@gmail.com>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Reiser4 und LZO compression
References: <20060827003426.GB5204@martell.zuzino.mipt.ru>	 <44F322A6.9020200@namesys.com> <20060828173721.GA11332@hello-penguin.com>	 <44F332D6.6040209@namesys.com> <1156801705.2969.6.camel@nigel.suspend2.net>
In-Reply-To: <1156801705.2969.6.camel@nigel.suspend2.net>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:
> For Suspend2, we ended up converting the LZF support to a cryptoapi
> plugin. Is there any chance that you could use cryptoapi modules? We
> could then have a hope of sharing the support
It is in principle a good idea, and I hope we will be able to say yes. 
However, I have to see the numbers, as we are more performance sensitive
than you folks probably are, and every 10% is a big deal for us.
