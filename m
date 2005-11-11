Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbVKKSk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbVKKSk1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 13:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbVKKSk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 13:40:27 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:50974 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751004AbVKKSk0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 13:40:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UqLAfk8mEZlrkC3Lonc6rl1cVlOOIBs+SPH8+z+bNZZnfbw+VKvI7l4cK2+1y01f28Oc7VGRN6UH6B3uwfVDG3CSq+LQsq1GemDtkOdF1bfm6gKFPajwMSsh9D6w95H6O8w1uxbzBICEaERdAgYDpoiF/w71idGz8i+7FWUiJms=
Message-ID: <195c7a900511111040p7947267brd99ce0be3c1130f4@mail.gmail.com>
Date: Fri, 11 Nov 2005 18:40:25 +0000
From: roucaries bastien <roucaries.bastien@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [BUG] Ali snd soft lookup on 2.6.14 (regression)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <s5hr79nz3b4.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <195c7a900511101418r25aa43e6gc5cdeeac17aa0c7c@mail.gmail.com>
	 <s5hr79nz3b4.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/05, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 10 Nov 2005 22:18:36 +0000,
> roucaries bastien wrote:
> >
> > Recently I upgrade from 2.6.10 to 2.6.14 and I my sound card doesn't
> > work anymore.
> Does the patch below fix?
It fix the BUG but I have always no sound :-(

dmesg shows now:

AC'97 1 does not respond - RESET
AC'97 1 access is not valid [0xffffffff], removing mixer.

I hope it help

PS: HZ is 1000

>
> Takashi
