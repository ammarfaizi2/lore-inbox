Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbUALBKl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 20:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265128AbUALBKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 20:10:40 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:10057 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S261807AbUALBKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 20:10:40 -0500
Message-ID: <4001F40C.8040006@samwel.tk>
Date: Mon, 12 Jan 2004 02:10:36 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][TRIVIAL] Remove bogus "value 0x37ffffff truncated to
 0x37ffffff" warning.
References: <Pine.LNX.4.44.0401111649160.20018-100000@bigblue.dev.mdolabs.com>
In-Reply-To: <Pine.LNX.4.44.0401111649160.20018-100000@bigblue.dev.mdolabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> Also, most important, the `make bzImage` does not give any warnings.

Hmmm. Did you get the original warning that we were talking about, 
before any changes were made? It still gives *me* the warnings, 
regardless of how it's written. What arch/compiler are you on? If you're 
on an arch/compiler that makes gas do 32-bit arithmetic, you're not 
going to get any warning -- it's going to be fine, because of gas's 
warning logic. I use an i386/gcc 3.3 system (debian unstable). Do you 
get no warnings as well on that configuration?

-- Bart
