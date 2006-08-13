Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbWHMTx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWHMTx6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 15:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWHMTx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 15:53:58 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:29160 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751395AbWHMTx5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 15:53:57 -0400
Message-ID: <44DF834E.4020302@garzik.org>
Date: Sun, 13 Aug 2006 15:53:50 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Daniel Phillips <phillips@google.com>
CC: David Miller <davem@davemloft.net>, a.p.zijlstra@chello.nl,
       netdev@vger.kernel.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 8/9] 3c59x driver conversion
References: <20060808193447.1396.59301.sendpatchset@lappy>	<44D9191E.7080203@garzik.org>	<44D977D8.5070306@google.com> <20060808.225537.112622421.davem@davemloft.net> <44DF7FB9.8020003@google.com>
In-Reply-To: <44DF7FB9.8020003@google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> That is why it has not yet been submitted upstream.  Respectfully, I
> do not think that jgarzik has yet put in the work to know if this anti
> deadlock technique is reasonable or not, and he was only commenting
> on some superficial blemish.  I still don't get his point, if there
> was one.  He seems to be arguing in favor of a jump-off-the-cliff
> approach to driver conversion.  If he wants to do the work and take
> the blame when some driver inevitably breaks because of being edited
> in a hurry then he is welcome to submit the necessary additional
> patches.  Until then, there are about 3 nics that actually matter to
> network storage at the moment, all of them GigE.

Quite whining and blaming the reviewer for a poor approach.

A "this driver is sane, VM-wise" flag is just plain stupid, and clearly 
fragments drivers.

In Linux, "temporary flags"... aren't.

	Jeff



