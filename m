Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966290AbWKTSRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966290AbWKTSRu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966334AbWKTSRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:17:50 -0500
Received: from relay.rinet.ru ([195.54.192.35]:48860 "EHLO relay.rinet.ru")
	by vger.kernel.org with ESMTP id S966290AbWKTSRs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:17:48 -0500
Message-ID: <4561F16C.1060205@mail.ru>
Date: Mon, 20 Nov 2006 21:18:20 +0300
From: Michael Raskin <a1d23ab4@mail.ru>
User-Agent: Thunderbird 2.0a1 (X11/20060809)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1-mm1+ memory problem
References: <45614A95.6090102@mail.ru>
In-Reply-To: <45614A95.6090102@mail.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (relay.rinet.ru [195.54.192.35]); Mon, 20 Nov 2006 21:17:46 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Raskin wrote:
> Short description: when X is loaded (maybe any heavy application is 
> sufficient, but I don't use anything heavy in console), 'free' says used 
> memory is growing.
> 
Tried driver vesa. Leak still exists.

About leak size: with dri, xscreensaver, and nothing loaded while true; 
do free >>free.log; sleep 1; done
shows ~100KB/s.
