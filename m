Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbUBQAkw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 19:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263466AbUBQAkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 19:40:52 -0500
Received: from mailbox6.ucsd.edu ([132.239.1.58]:13840 "EHLO mailbox6.ucsd.edu")
	by vger.kernel.org with ESMTP id S263462AbUBQAkv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 19:40:51 -0500
Message-ID: <40316310.9080805@cs.ucsd.edu>
Date: Mon, 16 Feb 2004 16:40:48 -0800
From: Diwaker Gupta <diwaker@cs.ucsd.edu>
Reply-To: diwaker@ucsd.edu
Organization: CS @ UCSD
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux TCP implementation
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: PASSED (v1.2.8 16341 i1H0enTw023803 mailbox6.ucsd.edu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe this question has already been burnt to death, but I wasn't able 
to find an answer on the archives or on the FAQ. So here goes:

I was just reading about the various TCP implementation -- Reno, Tahoe 
and Vegas in particular -- and I was wondering about the TCP 
implementation in Linux. AFAIK (and from looking at the source code), it 
seems current kernels are using a tweaked version of Reno. I'm also 
aware that at some point of time (2.1.x?) Vegas was introduced into the 
mainstream kernels, but then withdrawn.

I want to gather the LKML readers' thoughts on this -- to me it seems 
that TCP Vegas in superior to Reno in almost all ways, and will really 
help to bring down network congestion substantially if a large number of 
senders begin to use it (read "if introduced in the mainstream kernel"). 
The question then is, why is TCP Vegas not here yet? And are there any 
plans to incorporate it in the future?

-- 
Diwaker Gupta
Graduate Student, Computer Sc. and Engg.
University of California, San Diego
<http://www.cs.ucsd.edu/~dgupta>
