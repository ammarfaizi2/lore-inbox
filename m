Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263240AbUDPP5N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 11:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263315AbUDPP5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 11:57:12 -0400
Received: from dsl-217-207-128-218.uk.easynet.net ([217.207.128.218]:63618
	"EHLO butternut.transitive.com") by vger.kernel.org with ESMTP
	id S263240AbUDPPzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 11:55:38 -0400
Message-ID: <408001E6.7020001@treblig.org>
Date: Fri, 16 Apr 2004 16:55:18 +0100
From: "Dave Gilbert (Home)" <gilbertd@treblig.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, shannon@widomaker.com,
       Phil Oester <kernel@linuxace.com>
Subject: Re: NFS and kernel 2.6.x
References: <20040416011401.GD18329@widomaker.com> <1082079061.7141.85.camel@lade.trondhjem.org> <20040415185355.1674115b.akpm@osdl.org> <1082084048.7141.142.camel@lade.trondhjem.org> <20040416045924.GA4870@linuxace.com> <1082093346.7141.159.camel@lade.trondhjem.org> <20040416144433.GE2253@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-TL-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

> Maaybe TCP should be the default then ? In case no one finds the reason 
> why NFS over UDP is slower on 2.6.x than 2.4.x. It seems there are
> quite a few reports confirming the slowdown. Maybe Jamie Lokier is right in 
> theory?

While it is reasonable to make TCP default it is important that if there
is a real problem with UDP NFS that it is sorted.  Some of us have to
work with older machines and kernels on clients that don't support TCP NFS.

Dave

