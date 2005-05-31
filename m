Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVEaGIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVEaGIV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 02:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVEaGIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 02:08:21 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:65284 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S261197AbVEaGIT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 02:08:19 -0400
Message-ID: <429BFF51.4000401@stud.feec.vutbr.cz>
Date: Tue, 31 May 2005 08:08:17 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050506)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Parag Warudkar <kernel-stuff@comcast.net>
CC: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: RT patch breaks X86_64 build
References: <200505302141.31731.kernel-stuff@comcast.net> <200505302201.48123.kernel-stuff@comcast.net>
In-Reply-To: <200505302201.48123.kernel-stuff@comcast.net>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  tested this incoming email. See other headers to know if the email
  has beed identified as possible spam.  The original message
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

Parag Warudkar wrote:
> On Monday 30 May 2005 21:41, Parag Warudkar wrote:
> 
>>Realtime patch breaks the x86_64 build -
> 
> 
> Forgot to add - It's the latest patch against 2.6.12-rc5. My .config attached.

That doesn't look like a correct .config from a -RT kernel. Did you 
forget to run 'make oldconfig' ?

Michal
