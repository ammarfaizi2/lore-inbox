Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbTINIa2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 04:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbTINIa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 04:30:28 -0400
Received: from mail-15.iinet.net.au ([203.59.3.47]:2745 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262329AbTINIa1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 04:30:27 -0400
Message-ID: <3F642723.6000203@ii.net>
Date: Sun, 14 Sep 2003 16:30:27 +0800
From: Wade <neroz@ii.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030903 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] file locking memory leak
References: <20030912201316.GD21596@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20030912201316.GD21596@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> This patch fixes a memory leak in the file locking code.  Each attempt
> to unlock a file would result in the leak of a file lock.  Many thanks
> to Martin Josefsson for providing the testcase which enabled me to figure
> out the problem.
> 

Is this a problem for 2.4 as well?



