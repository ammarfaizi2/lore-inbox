Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965058AbWFIAud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965058AbWFIAud (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 20:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965068AbWFIAud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 20:50:33 -0400
Received: from wx-out-0102.google.com ([66.249.82.205]:43402 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965058AbWFIAuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 20:50:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=fdEVVc2cVM8R7lZIwJC2pF98UgR2iEDVrKymtJL8NR5ucU/x8V9QsIhqtg6Bde8llCeY4UJVxATFEwyfA/dDEfgT/uK8av5I0hH627mKkqgC6YWqYplCE8gVpwkLDGhEd5Gje3uHjGuCdYzJu/oOhopdooi9gBom3WvX+xEDnrw=
Message-ID: <986ed62e0606081750w1be36f9fn35d69bffbc27f294@mail.gmail.com>
Date: Thu, 8 Jun 2006 17:50:31 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "George Nychis" <gnychis@cmu.edu>
Subject: Re: what processor family does intel core duo L2400 belong to?
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <4488C098.90802@cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4488B159.2070806@cmu.edu>
	 <986ed62e0606081650k227c948dy2c675bedd7a254fa@mail.gmail.com>
	 <4488C098.90802@cmu.edu>
X-Google-Sender-Auth: 8a692310f20810a0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/06, George Nychis <gnychis@cmu.edu> wrote:
> Put me in your shoes, what would you test to see which one is the true
> choice?

I'd start by seeing which one (if either) will boot the system (with
CONFIG_X86_GENERIC disabled). In the past, when I've had trouble
deciding, this has actually eliminated more possibilities than you
might expect.

Beyond that, I don't know for certain what I would test with. Perhaps
I'd start with lmbench, or if I was using the system for 3D stuff,
perhaps framerates from glxgears or a 3D game. If I was using the
system for network stuff, I'd run network benchmarks. (Perhaps disk
benchmarks would be good too, but my experience is that network
performance tends to suffer first and/or more severely, especially if
Gigabit Ethernet or slow CPU's are involved.)

If both choices boot, the performance difference may be quite small.
-- 
-Barry K. Nathan <barryn@pobox.com>
