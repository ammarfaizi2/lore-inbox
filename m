Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263354AbTETAdx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 20:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263358AbTETAdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 20:33:53 -0400
Received: from holomorphy.com ([66.224.33.161]:31466 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263354AbTETAdw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 20:33:52 -0400
Date: Mon, 19 May 2003 17:46:36 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dan Kegel <dank@kegel.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       John Myers <jgmyers@netscape.com>, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: Comparing the aio and epoll event frameworks.
Message-ID: <20030520004636.GP2444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dan Kegel <dank@kegel.com>,
	Davide Libenzi <davidel@xmailserver.org>,
	John Myers <jgmyers@netscape.com>, linux-aio@kvack.org,
	linux-kernel@vger.kernel.org
References: <200305192333.QAA12018@pagarcia.nscp.aoltw.net> <Pine.LNX.4.55.0305191657540.6565@bigblue.dev.mcafeelabs.com> <3EC9807D.3080804@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EC9807D.3080804@kegel.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
>> Adding a single shot feature to epoll takes about 5 lines of code,
>> comments included :) You know how many reuqests I had ? Zero, nada.

On Mon, May 19, 2003 at 06:10:21PM -0700, Dan Kegel wrote:
> I thought edge triggered epoll *was* single-shot.
> - Dan

fs/eventpoll.c suggests "epoll" stands for "eventpoll" as opposed to
"edge-triggered". Davide, did the LT additions prompt the renaming or
was this always the case?


-- wli
