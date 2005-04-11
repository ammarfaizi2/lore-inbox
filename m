Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261809AbVDKQFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbVDKQFm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 12:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVDKQEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 12:04:30 -0400
Received: from hermes.domdv.de ([193.102.202.1]:17683 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261831AbVDKQDv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 12:03:51 -0400
Message-ID: <425A9FE5.1050407@domdv.de>
Date: Mon, 11 Apr 2005 18:03:49 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: 7eggert@gmx.de
CC: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH encrypted swsusp 3/3] documentation
References: <3RUc9-679-19@gated-at.bofh.it> <E1DL1Kg-0000sc-BX@be1.7eggert.dyndns.org>
In-Reply-To: <E1DL1Kg-0000sc-BX@be1.7eggert.dyndns.org>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert wrote:
> Andreas Steinmetz <ast@domdv.de> wrote:
> 
> 
>>+If you want to store your suspend image encrypted with a temporary
>>+key to prevent data gathering after resume you must compile
>>+crypto and the aes algorithm into the kernel - modules won't work
>>+as they cannot be loaded at resume time.
> 
> 
> Can't that be ensured by selecting these options?

Yes, it is ensured. The text is there to give some hint how to to make
this option selectable.

-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
