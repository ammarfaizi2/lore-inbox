Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbVK2AXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbVK2AXX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 19:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbVK2AXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 19:23:23 -0500
Received: from baldrick.bootc.net ([83.142.228.48]:2280 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S932313AbVK2AXW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 19:23:22 -0500
In-Reply-To: <20051129002801.GA9785@mipter.zuzino.mipt.ru>
References: <20051129002801.GA9785@mipter.zuzino.mipt.ru>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <D6440692-33C3-45F0-9112-C22332ED7072@bootc.net>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Chris Boot <bootc@bootc.net>
Subject: Re: [RFC] un petite hack: /proc/*/ctl
Date: Tue, 29 Nov 2005 00:23:19 +0000
To: Alexey Dobriyan <adobriyan@gmail.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Nov 2005, at 0:28, Alexey Dobriyan wrote:

> echo kill >/proc/$PID/ctl
> 	send SIGKILL to process
>
> echo term >/proc/$PID/ctl
> 	send SIGTERM to process

Pardon me for my ignorance, but what's wrong with the following?

kill -KILL $PID
     and
kill -TERM $PID

Thanks,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/


