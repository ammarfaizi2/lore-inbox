Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWHIQg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWHIQg0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 12:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWHIQg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 12:36:26 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:52185 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751018AbWHIQgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 12:36:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PpNTNulHbMNX6p35/lVEo9IXxX+yN7Lz2h/rbKFbIHLSIwt40RJFjkT6myBwa3bvni2AOOJQbXUIDzv39NdokAhRLWN7Y4K2914RcnJ+L8+Hf6LQnOBaIrw2inISWPB2wHcFknXds6xkIXU0zbQJ8sV7/DbPWNcQCvNcAZxUp2w=
Message-ID: <d120d5000608090936j794449e9v6c57ac44801bd3d5@mail.gmail.com>
Date: Wed, 9 Aug 2006 12:36:23 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Sergei Steshenko" <steshenko_sergei@list.ru>
Subject: Re: [Alsa-user] another in kernel alsa update that breaks backward compatibilty?
Cc: "Sam Ravnborg" <sam@ravnborg.org>,
       "Benoit Fouet" <benoit.fouet@purplelabs.com>,
       "Gene Heskett" <gene.heskett@verizon.net>,
       alsa-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20060809191748.7550edaa@comp.home.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608091140.02777.gene.heskett@verizon.net>
	 <20060809184658.2bdfb169@comp.home.net>
	 <44DA05C9.5050600@purplelabs.com>
	 <20060809160043.GA12571@mars.ravnborg.org>
	 <20060809191748.7550edaa@comp.home.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/06, Sergei Steshenko <steshenko_sergei@list.ru> wrote:
> On Wed, 9 Aug 2006 18:00:43 +0200
> Sam Ravnborg <sam@ravnborg.org> wrote:
>
> > On Wed, Aug 09, 2006 at 05:56:57PM +0200, Benoit Fouet wrote:
> > > >
> > > >Demand stable ABI.
> > > >
> > > >
> > > >
> > > sorry for the noise, but it's been a while now since i began reading
> > > mails from this list, and i must admit i don't always (never?) see the
> > > point of such messages...
> > > if you can help me understand, i'll be very happy to get something more
> > > detailed from you...
> > Documentation/stable_api_nonsense.txt
> >
> >       Sam
> >
>
> I love senselessness and technical incompetence of the document.
>
> As I was taught at school, to prove that a statement is wrong one
> has to prove that it is wrong once.
>

Yep, the only trick is that you need a valid proof ;)

> Regardless of what the document says stable ABI can be achieved
> today - run a chosen Linux kernel version + chosen ALSA version under XEN or
> similar, and assign sound card to these (chosen Linux kernel version +
> chosen ALSA version).
>
> Redirect sound ('ncat' + friends) to this (chosen Linux kernel version +
> chosen ALSA version) from your kernel in which developers refuse
> to ensure stable ABI.
>
> Because of the chosen (kernel+ALSA) you have stable ABI regardless
> of what Documentation/stable_api_nonsense.txt says and ALSA + kernel
> developers think.
>

You are confused. By your logic you do not need XEN at all - just take
a kernel version + alsa and never change/update it - and viola!
"stable" ABI.

-- 
Dmitry
