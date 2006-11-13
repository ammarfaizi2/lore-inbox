Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754761AbWKMObr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754761AbWKMObr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 09:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754772AbWKMObr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 09:31:47 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:60944 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1754761AbWKMObq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 09:31:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QED+xC1kORRrQNNAnzlQeuslCxQKnPk0TWw+Snu6pcl15raoaBrGQQ/cpKkoMMPCqChDLf4Ev0Epf1ZT0MKOIs+YUK/OfJb8EuPEFMEtv3mWLxwamXrXhLmsRlyOX/mDgPag6kDPNVWz++vGPjmf0hKMXJm6rJYu2CgmwI8SjMA=
Message-ID: <cda58cb80611130631v1d560a2chcfcee904f6be317d@mail.gmail.com>
Date: Mon, 13 Nov 2006 15:31:45 +0100
From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
To: "James Simmons" <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] fbmem: is bootup logo broken for monochrome LCD ?
Cc: "Linux Fbdev development list" 
	<linux-fbdev-devel@lists.sourceforge.net>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0611131415270.25397@pentafluge.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45535C08.5020607@innova-card.com>
	 <Pine.LNX.4.64.0611122138030.9472@pentafluge.infradead.org>
	 <cda58cb80611130153n60579de0w2ebb59b050595b3b@mail.gmail.com>
	 <Pine.LNX.4.64.0611131415270.25397@pentafluge.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/06, James Simmons <jsimmons@infradead.org> wrote:
>
> >> There are quite a few bugs in the code. I have a patch I have been working
> >> on for some time. The patch does the following:
> >>
> >
> > I'd like to give your patch a try but have some trouble to apply it
> > cleanly. Care to resend it ?
>
> Which tree are you working off ?> The patch is against linus git tree.
>

I use the same tree. It seems that the patch get corrupted when it
reached me. Care to attach it next time ?

> >> I.
> >>         Merge slow_imageblit and color_imageblit into one function.
> >> II.
> >>         The same code works on both big endian and little endian machines
> >
> > Does this suppose to fix this issue I encountered:
> >
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=116315548626875&w=2
>
> This should fix the problems you reported. I tested this patch on a big
> endian and little endian framebuffer on a little endian machine.
>

Something I'm still missing hope you can shed some light there. Why
does the current code work on Rafael's machine (little endian one
using vesa driver) but not on mine which is a little endian one as
well ?

Thanks
-- 
               Franck
