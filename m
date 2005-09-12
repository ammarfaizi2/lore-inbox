Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbVILQ5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbVILQ5i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 12:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbVILQ5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 12:57:38 -0400
Received: from mail.aknet.ru ([82.179.72.26]:7692 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S932093AbVILQ5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 12:57:37 -0400
Message-ID: <4325B378.9080000@aknet.ru>
Date: Mon, 12 Sep 2005 20:57:28 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Jan Beulich <JBeulich@novell.com>
Cc: vandrove@vc.cvut.cz, linux-kernel@vger.kernel.org
Subject: Re: [patch] x86: fix ESP corruption CPU bug (take 2)
References: <431C20560200007800023E6F@emea1-mh.id2.novell.com> <432438F0.4090003@aknet.ru> <432546350200007800024DFF@emea1-mh.id2.novell.com>
In-Reply-To: <432546350200007800024DFF@emea1-mh.id2.novell.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Jan Beulich wrote:
>>Do you mean, eg, this?
>>http://www.ussg.iu.edu/hypermail/linux/kernel/0409.2/1533.html 
> No, I don't. This talks about going through ring 1 intermediately,
> which isn't what I have in mind.
Well, like I said, 2 approaches do use the
kernel stack for the 16bit stack. One approach
uses ring-1 trampoline, the other one doesn't.
The posting I pointed to, was explicit about
the stack usage, but as for the ring-0 approach
while still using the kernel stack - here it is:
http://www.ussg.iu.edu/hypermail/linux/kernel/0410.0/1402.html

Is this what you mean? This is pretty much all
about it, the third approach is in the kernel,
and there were no more, even under discussion.

