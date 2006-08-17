Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbWHQJfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbWHQJfh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 05:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWHQJfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 05:35:37 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:13858 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932369AbWHQJfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 05:35:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MTxXhJtTc4ghBijH7ZKhqtFDZTclhhQOzmluaDjePV1cnPOo6taQ/UN2srPPUTL0vGWHeQVos9cdckURSAlV/4vFJZplH5tD9RfjLUkFPcnbl1PZnlB11LjErkg11PPOFh6tyHshWUtK6TLaiGOtMlaSwZwcgu/6gBYLYsGoRUM=
From: Patrick McFarland <diablod3@gmail.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: GPL Violation?
Date: Thu, 17 Aug 2006 05:36:43 -0400
User-Agent: KMail/1.9.1
Cc: Anonymous User <anonymouslinuxuser@gmail.com>,
       linux-kernel@vger.kernel.org
References: <40d80630608162248y498cb970r97a14c582fd663e1@mail.gmail.com> <200608170242.40969.diablod3@gmail.com> <44E429B3.7030607@s5r6.in-berlin.de>
In-Reply-To: <44E429B3.7030607@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608170536.44733.diablod3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 August 2006 04:32, Stefan Richter wrote:
> Patrick McFarland wrote:
> > They don't have to release source code for any module you wrote from
> > scratch themselves, but said modules cannot say they are GPL (ie, they
> > have to poison the kernel).
> >
> > Also, said kernel modules have to be real modules and not statically
> > linked into the kernel, and said modules have to have the compiled
> > component objects (ie, *.o) available so people can relink them into new
> > modules to work with new kernels.
>
> I never heard that static vs. dynamic linking mattered WRT licensing, at
> least if the unmodified GPL is involved.

AFAICT you can't link GPL to non-GPL code and ship the product without heading 
deep into grey area territory. Both the GPL and LGPL has specific wording for 
certain cases (such as allowing LGPL (possibly GPL too?) to link to closed 
source system libraries and the reverse as well), but its really icky to link 
GPL to closed source code in any form.

> If a driver author doesn't want 
> to publish under the terms of GPL, an implementation in userspace may
> make it possible to avoid linking with GPL code.

But doesn't that force the GPL code to rely on closed source code, and not 
function properly without it? I remember a part in the GPL about not allowing 
that, but I can't seem to find it atm.

> Here are a few pointers to the opinion of FSF as published in their FAQ.
> (I doubt that the organization FSF is among the copyright holders of
> Linux, but the FSF is copyright holder of the GPL and authors of GPL run
> FSF. Therefore the FSF's statements are certainly relevant for you to
> consider.)

Now thats pretty useful information. I think everyone should bookmark those 
and file those away for later, I sure am. Thanks for finding those.

-- 
Patrick McFarland || www.AdTerrasPerAspera.com
"Computer games don't affect kids; I mean if Pac-Man affected us as kids,
we'd all be running around in darkened rooms, munching magic pills and
listening to repetitive electronic music." -- Kristian Wilson, Nintendo,
Inc, 1989

