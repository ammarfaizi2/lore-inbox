Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262836AbUKXU1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262836AbUKXU1M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 15:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbUKXUYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 15:24:43 -0500
Received: from tron.kn.vutbr.cz ([147.229.191.152]:32019 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S262836AbUKXUYH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 15:24:07 -0500
Message-ID: <41A4EDE2.3030309@stud.feec.vutbr.cz>
Date: Wed, 24 Nov 2004 21:24:02 +0100
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041005)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Ford <david+challenge-response@blue-labs.org>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-rc2 and x86_64; spontaneous reboots
References: <41A4D5A4.3010605@blue-labs.org>
In-Reply-To: <41A4D5A4.3010605@blue-labs.org>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  identified this incoming email as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-4.2 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0000]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford wrote:
> Is anyone else experiencing spontaneous reboots within a few minutes of 
> bootup?  (If the system survives past the first 10 minutes, it stays up 
> for a long time, but it reliably does an instant reboot with no panic or 
> other indication a good 9 out of 10 times.  The system is purely idle, 
> nothing going on.  memtest86+ runs for hours with no failures.

Do the restarts occur exactly 5 minutes after bootup? That would 
indicate a problem with jiffies overflow. Probably some buggy driver.

Michal
