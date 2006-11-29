Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758765AbWK2EaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758765AbWK2EaP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 23:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758771AbWK2EaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 23:30:15 -0500
Received: from relay.rinet.ru ([195.54.192.35]:39898 "EHLO relay.rinet.ru")
	by vger.kernel.org with ESMTP id S1758765AbWK2EaN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 23:30:13 -0500
Message-ID: <456D0CC1.7070703@mail.ru>
Date: Wed, 29 Nov 2006 07:29:53 +0300
From: Michael Raskin <a1d23ab4@mail.ru>
User-Agent: Thunderbird 2.0a1 (X11/20060809)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc6-mm2 is ok (2.6.19-rc1-mm1+ memory problem)
References: <45614A95.6090102@mail.ru>
In-Reply-To: <45614A95.6090102@mail.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (relay.rinet.ru [195.54.192.35]); Wed, 29 Nov 2006 07:30:07 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Raskin wrote:
> I have a strange problem with 2.6.19-rc-mm kernels. After I load X, I 
> notice that memory is marked used at rate of tens of KB/s. Then it 

Tried 2.6.19-rc6-mm2. Now the problem is gone. Sometimes memory is 
getting maked used as before, but when the loss reaches a few MB's it is 
all freed. After 3 hours of X+all those scripts that cause leak + 
ThunderBird I can still shut down everything except a few processes and 
have only 50MB used. Script that demonstrated leak is now working 
without problems and without eating memory.

Thanks.
