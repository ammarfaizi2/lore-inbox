Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131614AbRAWXaY>; Tue, 23 Jan 2001 18:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131206AbRAWXaD>; Tue, 23 Jan 2001 18:30:03 -0500
Received: from esteel10.client.dti.net ([209.73.14.10]:37931 "EHLO
	nynews01.e-steel.com") by vger.kernel.org with ESMTP
	id <S130866AbRAWX34>; Tue, 23 Jan 2001 18:29:56 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Mathieu Chouquet-Stringer <mchouque@e-steel.com>
Newsgroups: e-steel.mailing-lists.linux.linux-kernel
Subject: Re: Modules not being found with 2.4.0 on a 486 based box
Date: 23 Jan 2001 18:29:51 -0500
Organization: e-STEEL Netops news server
Message-ID: <m3wvbl6e4w.fsf@shookay.e-steel.com>
In-Reply-To: <3A6E128D.7C436455@pacbell.net>
NNTP-Posting-Host: shookay.e-steel
X-Trace: nynews01.e-steel.com 980292495 7250 192.168.3.43 (23 Jan 2001 23:28:15 GMT)
X-Complaints-To: news@nynews01.e-steel.com
NNTP-Posting-Date: 23 Jan 2001 23:28:15 GMT
To: gnuman0@pacbell.net
X-Newsreader: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You need to install a recent version of modutils (at least 2.4.0) because
the directory structure changed as you noticed it and the new modutils are
able to deal with that.

gnuman0@pacbell.net (C Sanjayan Rosenmund) writes:
> Please cc: me as well, as I'm on to many lists as is. . .
> 
> Irecently built 2.4.0 on two diferent x486 PCs and neither of them
> recognised the new module directory structure found in the 2.4.x
> kernels.  I did not have this problem on the Pentium and better
> machines that I built this same kernel on.  I got around the problem
> by making a symlink from where the module actually was
> (/lib/modules/2.4.0/kernel/drivers/net/) to where the system was
> looking for it (/lib/modules/2.4.0/net/) and all is well. . .for now. 
> I was wondering if there was any light that could be shed on why this
> might happen?  I have only found this to be a problem on 486s,
> everything bigger has worked fine.  Details below:
> Feature		Working		Not Wotking
> Processor	Pentium +	486 (486DX2-66, 486DX-50)
> Distrobution	Debian unstable	Debian stable (unstable caused other
> problems)
> RAM		16Mb +		16Mb +
> Hdd size	1Gb +		540Mb +
> Modules involved Any		network cards (that is all I was using)
> 
> More info can be provided if needed.  This is low priority, I was
> wondering if you had any ideas why (or how to get around it, other
> than my solution).
> 
> Thank you all for your time, and for producing a kernel that is worth
> all this work <grin>.

-- 
Mathieu CHOUQUET-STRINGER              E-Mail : mchouque@e-steel.com
     Learning French is trivial: the word for horse is cheval, and
               everything else follows in the same way.
                        -- Alan J. Perlis
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
