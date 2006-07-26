Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751657AbWGZOw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbWGZOw0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 10:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751656AbWGZOw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 10:52:26 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:53839 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750744AbWGZOw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 10:52:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MqUnXAlEPwEjd0fWbyP3dv8bbkQgZgBrdSM4b7DQmbRyzUf/NNFHCSBRfHLOTsOBrHY3vHcRJSWLk9vnOfTNq7tNHigmg2qmub3XuiXRuRBzONr+DfcLSa+8kg277tr43XufOcGEKBMH2LNtGSaIUieqN5WgTRVY79m5xNmUHJc=
Message-ID: <f96157c40607260752h1cc2a004s8cab09ad7579677e@mail.gmail.com>
Date: Wed, 26 Jul 2006 14:52:24 +0000
From: "gmu 2k6" <gmu2006@gmail.com>
To: "Michael Buesch" <mb@bu3sch.de>
Subject: Re: hwrng on 82801EB/ER (ICH5/ICH5R) fails rngtest checks
Cc: "Jeff Garzik" <jgarzik@pobox.com>,
       "Philipp Rumpf" <prumpf@mandrakesoft.com>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200607261649.10947.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060725222209.0048ed15.akpm@osdl.org>
	 <200607261544.39532.mb@bu3sch.de>
	 <f96157c40607260721s43837f9er810da838ed56cf1b@mail.gmail.com>
	 <200607261649.10947.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/06, Michael Buesch <mb@bu3sch.de> wrote:
> On Wednesday 26 July 2006 16:21, gmu 2k6 wrote:
> > it just outputs this and stops with 2.6.18-rc2-HEAD (see dmesg for hashcode or
> > whatever that is which is appended as localversion)
> >
> > svn:~# hexdump /dev/hwrng
> > 0000000 ffff ffff ffff ffff ffff ffff ffff ffff
> > *
> >
> > with 2.6.17.6:
> > svn:~# hexdump /dev/hwrng
> > 0000000 ffff ffff ffff ffff ffff ffff ffff ffff
> > *
> >
> > this was without any rng-tools installed and no rngd running of course.
>
> Hm, so I would say the hardware either broken, or intel
> changed the way to read the random data from it. But I doubt they
> would change something like this on the ICH5.
>
> Who wrote the ICH driver? Jeff? Philipp?
> What do you think?

IIRC it was Jeff.
