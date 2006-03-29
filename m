Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbWC2QzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbWC2QzT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 11:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbWC2QzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 11:55:14 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:20329 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750840AbWC2QzM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 11:55:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h79uko2TToD5QkwrtaSkCwqCYrGPrqLYvmHnfUXuUUyTHKxH2CdRtPJKCx/cILEFx/nJwVPFuNOzNXwNXBFhZbvF2L8G1UFQUcnAau0/yzpB0NenJjHLitK+VULOAlKUgOJdK9BOS8wCeDnqy263VNaRpOAyRBN77AbjeFWGpL4=
Message-ID: <d120d5000603290855u40c0cc22vac326da31bf5f8aa@mail.gmail.com>
Date: Wed, 29 Mar 2006 11:55:03 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Romano Giannetti" <romanol@upcomillas.es>,
       "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
       linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: ALPS stop worked between 2.6.13 and 2.6.16
In-Reply-To: <20060329164330.GA8977@pern.dea.icai.upcomillas.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060327153624.GC8679@pern.dea.icai.upcomillas.es>
	 <d120d5000603270805u40916079ufe12eb22d478c954@mail.gmail.com>
	 <20060327190826.GA18193@pern.dea.icai.upcomillas.es>
	 <d120d5000603271112r35ba7100jceb8aaf3e8bf8c70@mail.gmail.com>
	 <20060329164330.GA8977@pern.dea.icai.upcomillas.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/06, Romano Giannetti <romanol@upcomillas.es> wrote:
>
> On Mon, Mar 27, 2006 at 02:12:26PM -0500, Dmitry Torokhov wrote:
> > On 3/27/06, Romano Giannetti <romanol@upcomillas.es> wrote:
> > >
> > > Udev is 054 (as per Mandriva 2005). Is that the culprit?
> >
> > [~/linux] grep udev Documentation/Changes
> > o  udev                   071                     # udevinfo -V
> > ...
>
> Bad news... I tried to upgrade udev to 088, but evidently this is not a
> trivial task. I had to reinstall back 054 to have the system working ok (I
> had a bunch of
>
> SYS: Mar 29 18:20:11 rukbat udevsend[17819]: unable to connect to event
> daemon, try to call udev directly
>
> but then nothing happened, no devices etc. So evidently the new udev is
> unable to cope with the old and maybe buggy Mandriva 2005 configuration[1].
> I unfortunately have no time to desentangle the dependency mess, so it's
> time to stop testing new kernels... unless anyone can point me to a "howto".
>

I am sorry to hear that. You might want to check on the hotplug list,
maybe someone there could offer you some guidance. To tell you the
truth I am still running with static /dev...

--
Dmitry
