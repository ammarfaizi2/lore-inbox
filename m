Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264763AbUEaUEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264763AbUEaUEv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 16:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264767AbUEaUEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 16:04:50 -0400
Received: from virgo.i-cable.com ([203.83.111.75]:53437 "HELO
	virgo.i-cable.com") by vger.kernel.org with SMTP id S264763AbUEaUEt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 16:04:49 -0400
Message-ID: <40BB88B5.8080300@ezrs.com>
Date: Mon, 31 May 2004 21:34:13 +0200
From: Michael Brennan <mbrennan@ezrs.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040509
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
I've recently started to follow this list.
I read the swap discussion here, and I was wondering about what Nick 
Pigging said about grepping the kernel tree.

Nick Piggin wrote:
 > For example, I have 57MB swapped right now. It allows me to instantly
 > grep the kernel tree. If I turned swap off, each grep would probably
 > take 30 seconds.

Are the pages swapped to disk as a result of the grep run?
Im still running 2.4.25. And when I do a grep on the linux kernel tree, 
it always takes at least 2 minutes at every run. Almost all physical 
ram, and 21MB of swap is used. Should the files read by grep be cached 
in memory/swap?

Michael Brennan
