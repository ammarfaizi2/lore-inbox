Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751962AbWI3UfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962AbWI3UfS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 16:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751946AbWI3UfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 16:35:17 -0400
Received: from wx-out-0506.google.com ([66.249.82.232]:26632 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751955AbWI3UfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 16:35:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kaW+99t8IjFokHZGaDeEgLk8CpJ/eFLQBArzdqRPge7DF+WwhKVNNmFzbZcYtSmrwzhEXNQhJXgOkiMeaIxq+e8icSSi/19ue1JRHtOnJ773MjljJ/rfWos6OR5bbRNClzhjZttoI5j2vwPrC87E2sx4HlXTG9v95L/lI8RzIfc=
Message-ID: <5a4c581d0609301335n224f0ea4r98de791282a73ba1@mail.gmail.com>
Date: Sat, 30 Sep 2006 22:35:14 +0200
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "Dave Jones" <davej@redhat.com>,
       "Alessandro Suardi" <alessandro.suardi@gmail.com>, jt@hpl.hp.com,
       "John W. Linville" <linville@tuxdriver.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-git9 wireless fixes break ipw2200 association to AP with WPA
In-Reply-To: <20060930183754.GB28868@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5a4c581d0609291225r4a2cbaacr35e5ef73d69f8718@mail.gmail.com>
	 <20060929202928.GA14000@tuxdriver.com>
	 <5a4c581d0609291340q835571bg9657ac0a68bab20e@mail.gmail.com>
	 <20060929212748.GA10288@bougret.hpl.hp.com>
	 <5a4c581d0609291504r40bc1796q715c5ffa41aa7b1b@mail.gmail.com>
	 <20060929224316.GA10423@bougret.hpl.hp.com>
	 <5a4c581d0609291552k7dc39685t15188bb5c881d3bd@mail.gmail.com>
	 <5a4c581d0609300527m1654f2cha56517e1c85f4606@mail.gmail.com>
	 <20060930183754.GB28868@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/06, Dave Jones <davej@redhat.com> wrote:
> On Sat, Sep 30, 2006 at 02:27:01PM +0200, Alessandro Suardi wrote:
>  >
>  > Good news, WPA association is back to work for me using
>  >  wireless_tools.29.pre10 and wpa_supplicant-0.4.9 with
>  >
>  >  2.6.18-git11 vanilla
>  >  2.6.18-git11 with reverted wireless fixes
>  >  2.6.18-git13
>  >
>  >  which appears to mean that backward compatibility of the
>  >  new tools with older kernel features has also been tested :)
>  >
>  > Dave, do you want me to file a request for updated FC5 RPMs
>  >  for wireless-tools and wpa_supplicant in bugzilla or is it
>  >   - already happening
>  >   - never going to happen
>  >  ?
>
> I'm not sure if we usually wait for a 'real' release, or if there's
> precedent for us shipping pre's before, but filing a bug-report
> is a good idea so that it doesn't go unnoticed when I eventually
> push a 2.6.19 update to FC5-updates in a few months.
>
>         Dave
>

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=208719
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=208720

respectively filed for wpa_supplicant and wireless-tools.

Thanks, ciao,

--alessandro

"Well a man has two reasons for things that he does
  the first one is pride and the second one is love
  all understandings must come by this way"

     (Husker Du, 'She Floated Away')
