Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262239AbVAJNaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbVAJNaK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 08:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262250AbVAJNaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 08:30:10 -0500
Received: from fyrebird.net ([217.70.144.192]:19426 "HELO fyrebird.net")
	by vger.kernel.org with SMTP id S262239AbVAJNaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 08:30:06 -0500
X-Qmail-Scanner-Mail-From: lethalman@fyrebird.net via fyrebird.net
X-Qmail-Scanner: 1.23 (Clear:RC:0(62.11.82.92):. Processed in 2.097606 secs)
Message-ID: <41E280B7.3080201@fyrebird.net>
Date: Mon, 10 Jan 2005 14:18:47 +0100
From: Lethalman <lethalman@fyrebird.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: patch to uselib()
References: <003f01c4f65e$9e4f91b0$b0e0a7c8@rootcon4qag3k5> <41E15413.7030509@fyrebird.net> <001501c4f699$3c066de0$b0e0a7c8@rootcon4qag3k5>
In-Reply-To: <001501c4f699$3c066de0$b0e0a7c8@rootcon4qag3k5>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Breno Silva Pinto wrote:
> Hi Lethalman,
> 
> I think i can use the same patch on 2.6.10 kernel , is there any problem ?
> 
> Att,

I didn't try 2.6 kernels yet, however it should work fine.
I think you can't use directly the patch because there should be other 
changes in the file between 2.4.28 and 2.6.10 ;)

Just modify the file manually, you only need to remove a line and add 
the same after the do_brk() call.

-- 
www.iosn.it * Amministratore Italian Open Source Network
www.fyrebird.net * Fyrebird Hosting Provider - Technical Department
