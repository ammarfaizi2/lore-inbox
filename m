Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263854AbUDFPSX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 11:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263868AbUDFPSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 11:18:23 -0400
Received: from ulysses.news.tiscali.de ([195.185.185.36]:524 "EHLO
	ulysses.news.tiscali.de") by vger.kernel.org with ESMTP
	id S263854AbUDFPSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 11:18:21 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Thomas Bach <blox@tiscali.de>
Newsgroups: linux.kernel
Subject: Re: Workaround for ReiserFS on root-filesystem
Date: Mon, 05 Apr 2004 21:57:48 +0200
Organization: Tiscali Germany
Message-ID: <4071BA3C.8080901@tiscali.de>
References: <1HYFq-4mw-45@gated-at.bofh.it> <1HYYj-4Ap-5@gated-at.bofh.it>
NNTP-Posting-Host: p213.54.49.246.tisdip.tiscali.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: ulysses.news.tiscali.de 1081264699 74154 213.54.49.246 (6 Apr 2004 15:18:19 GMT)
X-Complaints-To: abuse@tiscali.de
NNTP-Posting-Date: Tue, 6 Apr 2004 15:18:19 +0000 (UTC)
Cc: daniel@majorstua.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040317
X-Accept-Language: de-de, de, en
In-Reply-To: <1HYYj-4Ap-5@gated-at.bofh.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Andersen wrote:
>>I use ReiserFS for my root-filesystem while trying to upgrade to a newer
>>kernel-version (still using 2.4.20) I got a error, that / could not be
>>remounted read/write. After googling a bit I stumbled over the fact that
>>ReiserFS as root-filesystem doesn't work since version 2.4.22 (or
>>something like this).
>>
> Hmm.. It works perfectly fine for me with all 2.4.20-25 kernels, so you
> should not trust everything you find on google ;-)

I tried all kinds of versions (2.4.22, 2.4.25, 2.6.2 and as allready 
mentioned 2.6.5) non of them worked even after playing testing with all 
kinds of options...

> How big is your root partition? Which version of ReiserFS are you using?

The root partition is about 950Mb big (776 used...) and I am using
reiserfsprogs-3.6.11

		Thomas Bach
