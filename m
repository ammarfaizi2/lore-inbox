Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262594AbUKXKYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262594AbUKXKYq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 05:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262595AbUKXKYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 05:24:46 -0500
Received: from fmmailgate05.web.de ([217.72.192.243]:64384 "EHLO
	fmmailgate05.web.de") by vger.kernel.org with ESMTP id S262594AbUKXKYo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 05:24:44 -0500
Message-ID: <41A4610B.3020707@web.de>
Date: Wed, 24 Nov 2004 11:23:07 +0100
From: Michael Hunold <hunold-ml@web.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Justin Piszcz <jpiszcz@lucidpixels.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 Question w/4port Ethernet Card & MII Transceivers
References: <Pine.LNX.4.61.0411230759070.3740@p500>
In-Reply-To: <Pine.LNX.4.61.0411230759070.3740@p500>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm experiencing the same problems, see:
http://www.ussg.iu.edu/hypermail/linux/kernel/0409.0/0565.html

On 23.11.2004 14:02, Justin Piszcz wrote:
> Question regarding the warnings, it appears to find a MII transceiver 
> but then it warns saying it does not?

I'm having the same problem with a 2port card. After a cold boot, the 
transceivers are not found and I need to do a reset. Afterwards, 
everything is fine.

> Is it a problem?

For me, yes. I'm using one port to connect to my adsl provider. After a 
cold boot, this fails.

> If it is not using a HW tranceiver, does this cause a loss in performance?

I don't know.

Can you try to reboot the machine and see if the problem goes away (ie. 
the transceivers are found)?

Do you have a 2.4 kernel where the card works after a cold boot?

So far nobody has come up with a solution and I don't reboot the machine 
that often. But it's "good" to know that I'm not alone with the problem. ;-(

CU
Michael.
