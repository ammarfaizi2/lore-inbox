Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbWGSRJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWGSRJG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 13:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbWGSRJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 13:09:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:48411 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030205AbWGSRJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 13:09:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bMvbcFq5zyLGvcH+szOKz8ER2jF3zjWiuaAjbY0D940OKEERMR1/nlXsxk9p5KXOR2NaDJPPEAj5pV0YLzIJ32hkNxa2ZwJg7gGg7O9zSDe+uxsNHw7biL2TG+e6/7HTMUHXKLzqQsrIt7kjneEW+pbuO/AiRcKlUCXdPJBZpjI=
Message-ID: <29495f1d0607191009r736ed327y797e69ac4915e1e7@mail.gmail.com>
Date: Wed, 19 Jul 2006 10:09:03 -0700
From: "Nish Aravamudan" <nish.aravamudan@gmail.com>
To: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: oops in bttv
Cc: "Mauro Carvalho Chehab" <mchehab@infradead.org>,
       "Alex Riesen" <fork0@users.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       v4l-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       Martin.vGagern@gmx.net
In-Reply-To: <81b0412b0607170634p298ab59p3c52b8c9c0cc7661@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060711204940.GA11497@steel.home>
	 <1152962993.26522.18.camel@praia>
	 <81b0412b0607170634p298ab59p3c52b8c9c0cc7661@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/06, Alex Riesen <raa.lkml@gmail.com> wrote:
> On 7/15/06, Mauro Carvalho Chehab <mchehab@infradead.org> wrote:
> > > What I did was to call settings of the flashplayer and press on the
> > > webcam symbol there. The system didn't crash, just this oops:
> > >
> > > BUG: unable to handle kernel NULL pointer dereference at virtual address 0000006
> > > 5
> > Hmm... Are you using it on what machine? It might be related to an
> > improper handling at compat32 module.
>
> 32bit. PIV, 2Gb, highmem on.

Is this the same bug as http://bugzilla.kernel.org/show_bug.cgi?id=6869?

Thanks,
Nish
