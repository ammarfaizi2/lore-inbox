Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbWHQVkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbWHQVkY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 17:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbWHQVkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 17:40:24 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:24755 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932364AbWHQVkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 17:40:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pmJARKHZOArxOf6btHxQmRFexm/iwGwft0UvyTGndI089Jv8wYzcVf6vFQnRTJ0V+9zjbjthTTuQ1X3K1ODfZToUrMV2jnbUub/qBsxlQghTl50A4GRYf+4vq8RUjGrxzyJI4ql2YDTXaeyyy7gMuEyyiU1KI9l5UU1nkkvovro=
Message-ID: <9a8748490608171440h56fad8cesff32466a8beaf6f5@mail.gmail.com>
Date: Thu, 17 Aug 2006 23:40:21 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Jim Cromie" <jim.cromie@gmail.com>
Subject: Re: 2.6.18-rc4-mm1 Run-time of Locking API testsuite
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <44E4CC60.3080109@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44E4CC60.3080109@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/06, Jim Cromie <jim.cromie@gmail.com> wrote:
>
> Note the non-trivial execution time difference:
>
> soekris:~/pinlab# egrep -e 'Locking|Good' dmesg-2.6.18-rc4-*
> dmesg-2.6.18-rc4-mm1-sk:[   16.044699] | Locking API testsuite:
> dmesg-2.6.18-rc4-mm1-sk:[   96.083576] Good, all 218 testcases passed! |
> dmesg-2.6.18-rc4-sk:[   18.563808] | Locking API testsuite:
> dmesg-2.6.18-rc4-sk:[   19.693692] Good, all 218 testcases passed! |
>
Interresting. On my box it takes at most a few seconds (don't have
printk times enabled, so I can't give exact numbers). My best estimate
is 2-3 seconds to run the self tests.

I wonder what's so different about our machines. Mine is a Athlon64 X2
4400+ w/ 2GB RAM.

relevant config options look identical to yours... Strange..

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
