Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422825AbWJaG46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422825AbWJaG46 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 01:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422829AbWJaG46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 01:56:58 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:25879 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1422825AbWJaG45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 01:56:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h5AeITtMQXrZ43Gvm/vfeMQ4bVz16hPCdXI+7xZ4V6AeN5c0V0EvfUz9y17ERN3FYZzo8dm9zeVn567F6nVslB12ynWyPueu1pY5MSWPbCTm+VbmJI5CrJtYp9pJYVJ+4WOvhVJwia/CR1fXIW3vXlBn7cBAg2KoMq30uwEi/7o=
Message-ID: <5aa69f860610302256u61e30b2aj2501e5c1f5b7335@mail.gmail.com>
Date: Tue, 31 Oct 2006 08:56:55 +0200
From: "Fatih Asici" <asici.f@gmail.com>
Reply-To: fatih.asici@gmail.com
To: "Takashi Iwai" <tiwai@suse.de>
Subject: Re: [Alsa-devel] [RFC: 2.6.19 patch] snd-hda-intel: default MSI to off
Cc: "Prakash Punnoor" <prakash@punnoor.de>, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org, mingo@redhat.com, hnguyen@de.ibm.com,
       perex@suse.cz, "Stephen Hemminger" <shemminger@osdl.org>
In-Reply-To: <s5hhcxv1bc3.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200610050938.10997.prakash@punnoor.de>
	 <s5h64eh5yzx.wl%tiwai@suse.de> <s5h3b9l5ykv.wl%tiwai@suse.de>
	 <200610222229.16927.prakash@punnoor.de> <s5hhcxv1bc3.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/06, Takashi Iwai <tiwai@suse.de> wrote:
> At Sun, 22 Oct 2006 22:29:13 +0200,
> Prakash Punnoor wrote:
> >
> > Am Mittwoch 18 Oktober 2006 19:21 schrieb Takashi Iwai:
> >
> > > > Yes, it would be better to check the value and reset chip->msi if
> > > > not successful.  But it's not a fatal error, so the current code
> > > > should work.
> > >
> > > The below is the revised patch.
> >
> > I tried it and it works fine for me now (with the driver not using msi
> > automatically now).
>
> Thanks for checking.  I applied the patch to ALSA tree for the next
> push round.
>

It does not solve my problem. I still need to boot with pci=nomsi option.

Prakash: did you use Takashi's patch or Andrian's patch?
