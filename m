Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262609AbVA0NFC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbVA0NFC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 08:05:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbVA0NFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 08:05:01 -0500
Received: from tron.kn.vutbr.cz ([147.229.191.152]:37134 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S262609AbVA0NEz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 08:04:55 -0500
Message-ID: <41F8E6F5.6080304@stud.feec.vutbr.cz>
Date: Thu, 27 Jan 2005 14:04:53 +0100
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0 (X11/20050125)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cranium2003 <cranium2003@yahoo.com>
CC: kernerl mail <linux-kernel@vger.kernel.org>
Subject: Re: dmesg command output
References: <20050127071027.50338.qmail@web41401.mail.yahoo.com>
In-Reply-To: <20050127071027.50338.qmail@web41401.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

cranium2003 wrote:
> [...] On my RH9
> i386 arch i got 16kb output from dmesg. how to
> increase it?

man dmesg (parameter -s).
You may also want to increase the kernel buffer size in General Setup -> 
Kernel log buffer size (CONFIG_LOG_BUF_SHIFT).

Michal
