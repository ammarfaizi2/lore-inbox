Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVCCRtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVCCRtp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 12:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVCCRr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 12:47:29 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:39114 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261437AbVCCRqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 12:46:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=bK/iRFxd3RIuy7qawjrjZuKY9IxhQSDyPKXuL+wHleJuL5FftGLpCEfobmAfadHZgDsXc8yCI4NgJn01cJSqUo2VeY/UEK1ToQHS2nhXSfTzZNOvz8hKIi9x6Ri9HljADpzNvrMdrw3A1jCXTh6xcUGVUvb2TG8O0BGa5lAKLYk=
Message-ID: <29495f1d05030309455a990c5b@mail.gmail.com>
Date: Thu, 3 Mar 2005 09:45:34 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: intel 8x0 went silent in 2.6.11
Cc: LKML <linux-kernel@vger.kernel.org>, alsa-devel@lists.sourceforge.net
In-Reply-To: <4227085C.7060104@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <4227085C.7060104@drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Mar 2005 13:51:40 +0100, Pierre Ossman <drzeus-list@drzeus.cx> wrote:
> I just upgraded to Linux 2.6.11 and the soundcard on my machine went
> silent. All volume controls are correct and there are no errors
> reported. But no sound coming from the speakers. And here's the kicker,
> the headphones work fine!
> 2.6.10 still works so the bug appeared in one of the patches in between.
> The sound card is the one integrated into intels mobile ICH4 chipset.

There was some discussion of this on LKML a while ago. Are you sure
you have disabled "Headphone Jack Sense" and "Line Jack Sense" in
alsamixer?

Thanks,
Nish
