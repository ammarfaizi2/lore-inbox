Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266223AbUHHTwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266223AbUHHTwT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 15:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266214AbUHHTwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 15:52:18 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:21439 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S266223AbUHHTvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 15:51:36 -0400
Message-ID: <411684D5.8020302@colorfullife.com>
Date: Sun, 08 Aug 2004 21:53:57 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roger Luethi <rl@hellgate.ch>
CC: linux-kernel@vger.kernel.org, Netdev <netdev@oss.sgi.com>
Subject: Re: [2/3] via-rhine: de-isolate PHY
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger wrote:

> PHYs may come up isolated. Make sure we can send data to them. This code
> section needs a clean-up, but I prefer to merge this fix in isolation.
>
What was the phyid value for the isolated PHYs?

I know that PHYs go into isolate mode if the startup id is wired to 0, 
but I haven't figured out what's necessary to initialize them: Just 
clear the isolate bit or is it necessary to set the id to a nonzero value.

--
    Manfred

