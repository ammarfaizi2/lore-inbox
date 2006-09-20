Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWITV3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWITV3q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 17:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWITV3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 17:29:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:51505 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932132AbWITV3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 17:29:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=aN1C23jUgBPZXAu00w6I0u75pve4YCmrJPKCz+5gtmTosxD7feAoIMGmuUZK+y44LPRepe0pBWHhuxVTQvz81U38WTngHU6Vu6vsaaN7QpS2CX5vA0ZUcvfD2Ev+Bhk8Q+uGujmmSjEuDU5tw4lEqjLnrAfa6fTHX0tOfp7xbhE=
Message-ID: <d120d5000609201429m753de40fo194d48427402c6cd@mail.gmail.com>
Date: Wed, 20 Sep 2006 17:29:43 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.19 -mm merge plans (input patches)
Cc: linux-kernel@vger.kernel.org, "Dave Jones" <davej@redhat.com>,
       "Marek Vasut" <marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/06, Andrew Morton <akpm@osdl.org> wrote:
>
> remove-silly-messages-from-input-layer.patch

I firmly believe that we should keep reporting these conditions. This
way we can explain why keyboard might be losing keypresses. I am open
to changing the message text. Would "atkbd.c: keyboard reported error
condition (FYI only)" be better? It is KERN_DEBUG after all.

> stowaway-keyboard-support.patch
> stowaway-keyboard-support-update.patch

stowaway driver is in my tree now.

> stowaway-vs-driver-tree.patch

This is required for Greg's changes which I am unconvinced are needed.

> input-i8042-disable-keyboard-port-when-panicking-and-blinking.patch
> i8042-activate-panic-blink-only-in-x.patch

There was a concern that blinking is useful even when not running X.
Do you have any input?

> wistron-fix-detection-of-special-buttons.patch

Will apply.

-- 
Dmitry
