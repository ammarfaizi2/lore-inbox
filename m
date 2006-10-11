Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161209AbWJKUQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161209AbWJKUQZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 16:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161216AbWJKUQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 16:16:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:33573 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161209AbWJKUQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 16:16:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DFh2BzaXdJ9DJx7obguc5vWOykxLEq05MSVOExkjyBMvahRoBz5oRkWau8OdZ+eAr26B/ez6olU6oPbzVeLenznhfKAEzyMsAvZS3ZgkP5ndK78eJynefQ2KSL9iZFenoxAgJWkbWG7JrSkC1U83cP7z2BRC2Y2fxBg/+4Rqn9E=
Message-ID: <d120d5000610111316o1d4c1f4fu10b5fc9cd643dd3d@mail.gmail.com>
Date: Wed, 11 Oct 2006 16:16:22 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: Early keyboard initialization?
Cc: "Samuel Thibault" <samuel.thibault@ens-lyon.org>,
       linux-kernel@vger.kernel.org, "Greg KH" <gregkh@suse.de>
In-Reply-To: <20061011130832.c9e9b4d5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061006204254.GD5489@bouh.residence.ens-lyon.fr>
	 <200610072158.55659.dtor@insightbb.com>
	 <20061011130832.c9e9b4d5.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/06, Andrew Morton <akpm@osdl.org> wrote:

> Anyway, I'll duck this.  Samuel, an appropriate way to make this happen
> would be to talk Dmitry into a patch, let it cook in his tree for a couple
> of months, then merge it into 2.6.20-early.
>

I don't have anything against having keyboards initialized early, I
just want hardware to work the same way if possible, at least for more
common hardware. And there are increasing number of USB keyboards in
the wild.

-- 
Dmitry
