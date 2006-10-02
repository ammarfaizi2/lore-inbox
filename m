Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965136AbWJBRM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965136AbWJBRM0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 13:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965137AbWJBRMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 13:12:25 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:48859 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S965136AbWJBRMY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 13:12:24 -0400
Date: Mon, 2 Oct 2006 10:11:47 -0700
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: "John W. Linville" <linville@tuxdriver.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>
Subject: Re: 2.6.18-git9 wireless fixes break ipw2200 association to AP with WPA
Message-ID: <20061002171147.GC14535@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <5a4c581d0609291225r4a2cbaacr35e5ef73d69f8718@mail.gmail.com> <20060929202928.GA14000@tuxdriver.com> <5a4c581d0609291340q835571bg9657ac0a68bab20e@mail.gmail.com> <20060929212748.GA10288@bougret.hpl.hp.com> <5a4c581d0609291504r40bc1796q715c5ffa41aa7b1b@mail.gmail.com> <20060929224316.GA10423@bougret.hpl.hp.com> <5a4c581d0609291552k7dc39685t15188bb5c881d3bd@mail.gmail.com> <5a4c581d0609300527m1654f2cha56517e1c85f4606@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a4c581d0609300527m1654f2cha56517e1c85f4606@mail.gmail.com>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2006 at 02:27:01PM +0200, Alessandro Suardi wrote:
> 
> Good news, WPA association is back to work for me using
> wireless_tools.29.pre10 and wpa_supplicant-0.4.9 with
> 
> 2.6.18-git11 vanilla
> 2.6.18-git11 with reverted wireless fixes
> 2.6.18-git13
> 
> which appears to mean that backward compatibility of the
> new tools with older kernel features has also been tested :)

	We can't really test everything, but at least we try to do the
basics. The strong versioning of the API does help with regards to
this kind of change.

> Dave, do you want me to file a request for updated FC5 RPMs
> for wireless-tools and wpa_supplicant in bugzilla or is it
>  - already happening
>  - never going to happen
> ?

	I believe we are actually pretty close to FC6, which should
have all the right bits...

> Thanks, ciao,
> 
> --alessandro

	Ciao...

	Jean
