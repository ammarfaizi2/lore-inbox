Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbWFHXu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbWFHXu6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 19:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965047AbWFHXu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 19:50:58 -0400
Received: from wx-out-0102.google.com ([66.249.82.207]:34756 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964875AbWFHXu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 19:50:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=XgGrpCm+vtO8YBFsSiSPKbPXuhRWRj9xNR3ZTq5eqg2WDk72H2I2R44OmE1wIUqTb7FZZePNN/cAnfMQTcwnjG8Zb0p2fYdA1dZqYYE5s/6x6qhRYXZVTT+Li8QmxVbvo0ahnrgXYhPnWhlWR+6pDMu6Wh4smMog0Hi7Nzh2e+4=
Message-ID: <986ed62e0606081650k227c948dy2c675bedd7a254fa@mail.gmail.com>
Date: Thu, 8 Jun 2006 16:50:51 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "George Nychis" <gnychis@cmu.edu>
Subject: Re: what processor family does intel core duo L2400 belong to?
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <4488B159.2070806@cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4488B159.2070806@cmu.edu>
X-Google-Sender-Auth: 3e39870571e88d8e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/06, George Nychis <gnychis@cmu.edu> wrote:
> My guess is the "Pentium-4/Celeron(P4-based)/Pentium-4 M/Xeon" family,
> but maybe someone has a different opinion or can support it.
>
> Here is the /proc/cpuinfo:
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 14
[snip]

"Pentium-4/Celeron(P4-based)/Pentium-4 M/Xeon" are all family 15, not family 6.

I have a Pentium M, it's family 6 model 13. Also, AFAIK the Intel Core
is based on the Pentium M (which in turn is based on Pentium III). So,
my personal best guess would be to choose "Pentium M".

Unfortunately, I don't have one of these (Intel Core) at this point,
so I can't test it myself...
-- 
-Barry K. Nathan <barryn@pobox.com>
