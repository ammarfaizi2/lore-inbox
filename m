Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264422AbUEEKEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264422AbUEEKEr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 06:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264427AbUEEKEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 06:04:47 -0400
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:28994 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S264422AbUEEKEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 06:04:45 -0400
Message-ID: <4098BC2B.4080601@samwel.tk>
Date: Wed, 05 May 2004 12:04:27 +0200
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: nl, en-us, en
MIME-Version: 1.0
To: Libor Vanek <libor@conet.cz>
CC: "Richard B. Johnson" <root@chaos.analogic.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Read from file fails
References: <20040503000004.GA26707@Loki> <Pine.LNX.4.53.0405030852220.10896@chaos> <20040503150606.GB6411@Loki> <Pine.LNX.4.53.0405032020320.12217@chaos> <20040504011957.GA20676@Loki> <4097A94C.8060403@samwel.tk> <20040505095406.GC5767@Loki>
In-Reply-To: <20040505095406.GC5767@Loki>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No (on samwel.tk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Libor Vanek wrote:
> OK - how can I "notify" userspace process? Signals are "weak" - I need
 > to send some data (filename etc.) to process. One solution is "on this
 > signal call this syscall and result of this syscall will be data you
 > need" - but I'd prefer to handle this in one "action".

My first thoughts are to make it a blocking call.

--Bart
