Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWHGU3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWHGU3a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 16:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWHGU3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 16:29:30 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:6602 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932250AbWHGU31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 16:29:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pOd3V2UVZtPGAyYrhiyqdqhok7apAxUJ7TcAPVRPrKIcGjArLAGDeVOlSx8ffrTkCMUEMmA/8smiLyduXFX9zEUTOmeNgpVxW7cV1LsZdtxomPPJ35XYi6e29FRZOrbLAl17hdiKqRuObj1V8n6s+SkuEV4nBBDBBcaipEV2O98=
Message-ID: <5bdc1c8b0608071329r68cbaefboef4ae109203f1b58@mail.gmail.com>
Date: Mon, 7 Aug 2006 13:29:26 -0700
From: "Mark Knecht" <markknecht@gmail.com>
To: "Daniel Walker" <dwalker@mvista.com>
Subject: Re: Call Trace: 2.6.17-rt5: Call Trace: <ffffffff802500fd>{out_of_memory+55}
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "Ingo Molnar" <mingo@elte.hu>
In-Reply-To: <1154965007.18476.34.camel@c-67-188-28-158.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5bdc1c8b0608070819w653368cm82112655a7b98ec4@mail.gmail.com>
	 <1154965007.18476.34.camel@c-67-188-28-158.hsd1.ca.comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
   Thanks Daniel. I've not seen this before on any kernels myself.
I'll keep an eye on it and see if it comes up again.

   I appreciate the info.

Cheers,
Mark

On 8/7/06, Daniel Walker <dwalker@mvista.com> wrote:
> On Mon, 2006-08-07 at 08:19 -0700, Mark Knecht wrote:
> > Hi all,
> >    I've never seen this on 2.6.17-rt5. Up until today it had always
> > been quite stable. I was running MythTV at the time. Nothing out of
> > the ordinary.
>
> Those message are cause by the system running out of memory. I've see
> MythTV make the system run out of memory on non-RT kernels (must be a
> memory leak someplace). So I wouldn't think it related to any real time
> changes.
>
> >    Excuse my lack of experience here but after an event like this what
> > is the proper way to make sure the kernel is as stable as it can be?
> > Do I need to clean anything up? Reboot? Or is the cleanup all
> > automatic and everything is fine?
>
> The kernel will kill some running user space tasks to free memory. But
> the kernel should be fine after that.
>
> Daniel
>
>
