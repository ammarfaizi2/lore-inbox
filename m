Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753159AbWKGUhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753159AbWKGUhy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 15:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753192AbWKGUhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 15:37:54 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:63670 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1753159AbWKGUhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 15:37:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SdvqZU1eUfL/gsRgYowrUInFeZWEpfibKU9QX7W9jkiFWVx2Jt8nG01va1rKyXspBs63a29KRLLBrLmdyRiV5R1VYE5HLv9smzxAiHF0BH5gi/Jy4vc18IPzz/G5WUv5vLRtv6oc3mAWquVnRLlxXSFzCZvqHBykhAmbpDOpmfE=
Message-ID: <d120d5000611071237j509d0cbfxe441b68066fb75f5@mail.gmail.com>
Date: Tue, 7 Nov 2006 15:37:51 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Burman Yan" <yan_952@hotmail.com>
Subject: Re: [PATCH] HP Mobile data protection system driver with interrupt handling
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, khali@linux-fr.org
In-Reply-To: <BAY20-F50109D67E42239D2B911AD8F20@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d120d5000611061418i65f27cd6w1c60692aff8bd1b1@mail.gmail.com>
	 <BAY20-F50109D67E42239D2B911AD8F20@phx.gbl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/06, Burman Yan <yan_952@hotmail.com> wrote:
>
> >From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
> >To: "Andrew Morton" <akpm@osdl.org>
> >CC: "Burman Yan" <yan_952@hotmail.com>, linux-kernel@vger.kernel.org, "Jean
> >Delvare" <khali@linux-fr.org>
> >Subject: Re: [PATCH] HP Mobile data protection system driver with interrupt
> >handling
> >Date: Mon, 6 Nov 2006 17:18:53 -0500
> >
> >On 11/6/06, Andrew Morton <akpm@osdl.org> wrote:
> >>On Fri, 03 Nov 2006 18:33:31 +0200
> >>"Burman Yan" <yan_952@hotmail.com> wrote:
> >> > +
> >> > +static unsigned int mouse = 0;
> >>
> >>The `= 0' is unneeded.
> >>
> >> > +module_param(mouse, bool, S_IRUGO);
> >> > +MODULE_PARM_DESC(mouse, "Enable the input class device on module
> >>load");
> >
> >Does the parameter have to be called "mouse"? I'd rename it to "input"
> >and drop the work "class" from parameter description.
>
> Dropping the "class" seems logical, but calling the parameter input
> seems confusing to me - to a user that doesn't want to read too much
> manual/code and just wants to play around with the device (I do that
> sometimes)
> mouse sounds more reasonable to me.
>

Except that the device is more similar to a joystick than a mouse...

-- 
Dmitry
