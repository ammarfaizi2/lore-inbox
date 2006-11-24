Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757759AbWKXNYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757759AbWKXNYN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 08:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757763AbWKXNYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 08:24:13 -0500
Received: from relay.rinet.ru ([195.54.192.35]:45541 "EHLO relay.rinet.ru")
	by vger.kernel.org with ESMTP id S1757759AbWKXNYM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 08:24:12 -0500
Message-ID: <4566F26D.2010404@mail.ru>
Date: Fri, 24 Nov 2006 16:23:57 +0300
From: Michael Raskin <a1d23ab4@mail.ru>
User-Agent: Thunderbird 2.0a1 (X11/20060809)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1-mm1+ memory problem
References: <45614A95.6090102@mail.ru>
In-Reply-To: <45614A95.6090102@mail.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (relay.rinet.ru [195.54.192.35]); Fri, 24 Nov 2006 16:24:09 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Raskin wrote:
Strange thing: when run from xterm,

while true; do free | cat &>/dev/null; done

causes leak. While X is not loaded - no.

Also I have uploaded contents of /proc/page_owner after loosing more 
than 100M. (220M used, 29M - on page_owner, lessthan 50M - for 
processes). I will study it also.

http://bigtip.narod.ru/temp/page_owner.bz2
http://bigtip.narod.ru/temp/page_owner.gz

