Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbUK2Enu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbUK2Enu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 23:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbUK2Ent
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 23:43:49 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:54386 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261623AbUK2Ens (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 23:43:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:return-path:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:x-enigmail-supports:content-type:content-transfer-encoding;
        b=j2mvMbM0RcFZhSU3ngortwceeakwiXpE2hSTpF3p0TCLlgqHjkScSlQaXw4Ctj7bl35W3vpF6g8tRtbpEnUPG0oqsXNDi7QB/pPPFYeIcJiWCy6jWdMew0cYcEE1+BzdNIYfX6waiVApR/hPE0ZFxHfzWLTVadELgToCrgxxOec=
Message-ID: <41AAA94E.8090001@gmail.com>
Date: Mon, 29 Nov 2004 06:45:02 +0200
From: Matan Peled <chaosite@gmail.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jim Nelson <james4765@verizon.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Question about /dev/mem and /dev/kmem
References: <41AA9E26.4070105@verizon.net>
In-Reply-To: <41AA9E26.4070105@verizon.net>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Nelson wrote:

 > I was looking at some articles about rootkits on monolithic kernels, 
and had a thought.  Would a kernel config option to disable write > 
access to /dev/mem and /dev/kmem be a workable idea?


Yes, its a workable idea, and in fact, has already been implemented in 
grsecurity.

http://www.grsecurity.net/features.php

